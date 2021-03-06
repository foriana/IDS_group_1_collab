#Required packages -------------------------------------------------------

library(shiny)
#library(shinythemes) 
library(RColorBrewer)
#library(DT)   
library(scales)
library(ggridges)
library(gridExtra)
#library(extrafont)
library(tidyr)
library(dplyr)
library(countrycode)

#Load data ---------------------------------------------------------------
olympics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-27/olympics.csv')

summer_olympics <- olympics %>% 
  filter(season == "Summer") %>% 
  drop_na(medal) %>%
  mutate(countryName = countrycode(noc, "genc3c", "country.name")) %>% 
  mutate(countryName = ifelse(countryName == "United States", "USA", countryName)) %>% 
  mutate(countryName = ifelse(noc == "ALG", "Algeria", countryName)) %>% 
  mutate(countryName = ifelse(noc == "BAH", "Bahamas", countryName)) %>%
  mutate(countryName = ifelse(noc == "BUL", "Bulgaria", countryName)) %>%
  mutate(countryName = ifelse(noc == "CHI", "Chile", countryName)) %>%
  mutate(countryName = ifelse(noc == "CRC", "Costa Rica", countryName)) %>%
  mutate(countryName = ifelse(noc == "CRO", "Croatia", countryName)) %>%
  mutate(countryName = ifelse(noc == "DEN", "Denmark", countryName)) %>%
  mutate(countryName = ifelse(noc == "FIJ", "Fiji", countryName)) %>%
  mutate(countryName = ifelse(noc == "GER", "Germany", countryName)) %>%
  mutate(countryName = ifelse(noc == "GRE", "Greece", countryName)) %>%
  mutate(countryName = ifelse(noc == "GRN", "Grenada", countryName)) %>%
  mutate(countryName = ifelse(noc == "HAI", "Haiti", countryName)) %>%
  mutate(countryName = ifelse(noc == "INA", "Indonesia", countryName)) %>%
  mutate(countryName = ifelse(noc == "IRI", "Iran", countryName)) %>%
  mutate(countryName = ifelse(noc == "LAT", "Latvia", countryName)) %>%
  mutate(countryName = ifelse(noc == "MGL", "Mongolia", countryName)) %>%
  mutate(countryName = ifelse(noc == "NED", "Netherlands", countryName)) %>%
  mutate(countryName = ifelse(noc == "NGR", "Nigeria", countryName)) %>%
  mutate(countryName = ifelse(noc == "POR", "Portugal", countryName)) %>%
  mutate(countryName = ifelse(noc == "PUR", "Puerto Rico", countryName)) %>%
  mutate(countryName = ifelse(noc == "RSA", "South Africa", countryName)) %>%
  mutate(countryName = ifelse(noc == "SLO", "Slovenia", countryName)) %>%
  mutate(countryName = ifelse(noc == "SUI", "Switzerland", countryName)) %>%
  mutate(countryName = ifelse(noc == "UAE", "United Arab Emirates", countryName)) %>%
  mutate(countryName = ifelse(noc == "URU", "Uruguay", countryName)) %>%
  mutate(countryName = ifelse(noc == "VIE", "Vietnam", countryName)) %>%
  mutate(countryName = ifelse(noc == "ZIM", "Zimbabwe", countryName)) %>% 
  drop_na(countryName) %>% 
  count(countryName, medal) %>% 
  group_by(countryName) 

#Color palette ----------------------------------------------------------
medal_colors <- c(
  Gold = "#d5a500",
  Silver = "#b7b7b7",
  Bronze = "#a17419")


#Create user interface --------------------------------------------------

ui <- fluidPage(
  sidebarLayout( sidebarPanel( 
    
    selectizeInput(inputId  = "countryName",
                    label = "Select Country -- Up to Three",
                    choices =  sort(unique(summer_olympics$countryName))),
    checkboxGroupInput(inputId = "medal",
       label = "Type of Medal",
     choices = c("Gold", "Silver", "Bronze"),
    selected = c("Gold", "Silver", "Bronze"))
    ),
                 mainPanel() ),
  plotOutput(ouputId = "medalplot"))
                              

server <- function(input, output) { 
  output$medalplot <- renderPlot(
  summer_all %>% 
    filter(countryName == input$countryName, 
           medal== input$medal) %>% 
    ggplot(aes(x = year, y = n)) +
    geom_point() +
    scale_x_continuous(limits = input$years) +
    theme_minimal() + 
    labs(title= "Olympic Medals (1896-2016)")
)
}
shinyApp(ui = ui, server = server)

                                
