#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(tidyverse)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Influence of Interaction Effects in Multiple Linear Regression"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("int",
                     "Interaction term:",
                     min = -.1,
                     max = .1,
                     value = 0,
                     step = 0.01)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotlyOutput("c3_plot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  c3_plants <- read.csv(file = "https://mlammens.github.io/ENS-623-Research-Stats/data/Logan_Examples/Chapter9/Data/paruelo.csv")
  c3_plants$LAT <- as.numeric(scale(c3_plants$LAT, scale = FALSE))
  c3_plants$LONG <- as.numeric(scale(c3_plants$LONG, scale = FALSE))
  x_values <- c3_plants$LAT %>% 
    round(2)
  y_values <- c3_plants$LONG %>% 
    round(2)
  z_values <- log10(c3_plants$C3 + 0.1) %>% 
    round(2)
  # Define regression plane -------------------------------------------------
  # Construct x and y grid elements
  x_grid <- seq(from = min(c3_plants$LAT), to = max(c3_plants$LAT), length = 50)
  y_grid <- seq(from = min(c3_plants$LONG), to = max(c3_plants$LONG), length = 50)
  
  # Construct z grid by computing
  # 1) fitted beta coefficients
  # 2) fitted values of outer product of x_grid and y_grid
  # 3) extracting z_grid (matrix needs to be of specific dimensions)
  beta_hat <- c3_plants %>% 
    lm(data = ., log10(C3 + 0.1) ~ LAT*LONG) %>%
    coef()
  
  fitted_values <- crossing(y_grid, x_grid) %>% 
    mutate(z_grid = beta_hat[1] + beta_hat[2]*x_grid + beta_hat[3]*y_grid + beta_hat[4]*x_grid*y_grid)
  z_grid <- fitted_values %>% 
    pull(z_grid) %>%
    matrix(nrow = length(x_grid)) %>%
    t()
  
  # Construct z grid by computing
  # 1) fitted beta coefficients
  # 2) fitted values of outer product of x_grid and y_grid
  # 3) extracting z_grid (matrix needs to be of specific dimensions)
  beta_hat <- c3_plants %>% 
    lm(data = ., log10(C3 + 0.1) ~ LAT*LONG) %>%
    coef()
  
  # fitted_values <- crossing(y_grid, x_grid) %>% 
  #   mutate(z_grid = beta_hat[1] + beta_hat[2]*x_grid + beta_hat[3]*y_grid + input$int*x_grid*y_grid)
  # z_grid <- fitted_values %>% 
  #   pull(z_grid) %>%
  #   matrix(nrow = length(x_grid)) %>%
  #   t()
  # 
  # # Define text element for each point in plane
  # text_grid <- fitted_values %>% 
  #   pull(z_grid) %>%
  #   round(3) %>% 
  #   as.character() %>% 
  #   paste("C3: ", ., sep = "") %>% 
  #   matrix(nrow = length(x_grid)) %>%
  #   t()
  
  
   output$c3_plot <- renderPlotly({
     fitted_values <- crossing(y_grid, x_grid) %>% 
       mutate(z_grid = beta_hat[1] + beta_hat[2]*x_grid + beta_hat[3]*y_grid + input$int*x_grid*y_grid)
     z_grid <- fitted_values %>% 
       pull(z_grid) %>%
       matrix(nrow = length(x_grid)) %>%
       t()
     
     # Define text element for each point in plane
     text_grid <- fitted_values %>% 
       pull(z_grid) %>%
       round(3) %>% 
       as.character() %>% 
       paste("C3: ", ., sep = "") %>% 
       matrix(nrow = length(x_grid)) %>%
       t()
     
     plot_ly() %>%
       # # 3D scatterplot:
       # add_markers(
       #   x = x_values,
       #   y = y_values,
       #   z = z_values,
       #   marker = list(size = 5),
       #   hoverinfo = 'text',
       #   text = ~paste(
       #     "C3: ", z_values, "<br>",
       #     "LAT: ", y_values, "<br>",
       #     "LONG: ", x_values 
       #   )
       # ) %>%
       # Regression plane:
       add_surface(
         x = x_grid,
         y = y_grid,
         z = z_grid,
         hoverinfo = 'text',
         text = text_grid
       ) %>%
       # Axes labels and title:
       layout(
         title = "3D scatterplot and regression plane",
         scene = list(
           zaxis = list(title = "y: C3"),
           yaxis = list(title = "x2: LONG"),
           xaxis = list(title = "x1: LAT")
         )
       )
      # # generate bins based on input$bins from ui.R
      # x    <- faithful[, 2] 
      # bins <- seq(min(x), max(x), length.out = input$int + 1)
      # 
      # # draw the histogram with the specified number of bins
      # hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

