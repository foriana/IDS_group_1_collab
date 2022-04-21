library(shiny)
library(shinythemes) 
library(RColorBrewer)
library(DT)   
library(scales)
library(ggridges)
library(gridExtra)
library(extrafont)


olympics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-27/olympics.csv')


medal_colors <- c(
  Gold = "#d5a500",
  Silver = "#b7b7b7",
  Bronze = "#a17419")



ui <- fluidPage("Olympic Medal Results")
server <- function(input, output) {}
shinyApp(ui = ui, server = server)

