library(shiny)
library(lubridate) 
library(RColorBrewer)
library(plotly)   
library(ggthemes) 
ui <- fluidPage()
server <- function(input, output) {}
shinyApp(ui = ui, server = server)

medal_colors <- c(
  Gold = "#d5a500",
  Silver = "#b7b7b7",
  Bronze = "#a17419"
)