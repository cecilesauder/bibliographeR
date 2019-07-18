#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(bibliographeR)
library(plotly)
library(magrittr)



# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "purple",

   dashboardHeader(title = "BibliographeR"),

   dashboardSidebar(
      textInput("query", "Enter you keywords as in the NCBI webpage :"),
      actionButton("search", "Search"),
      sidebarMenu(
         menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
         menuItem("Citations Analysis", tabName = "citations", icon = icon("book")),
         menuItem("Abstracts Analysis", tabName = "abstract", icon = icon("newspaper")),
         menuItem("Authors Analysis", tabName = "authors", icon = icon("users"))
      )
   ),

   dashboardBody(
      tags$head(
         tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
      ),
      box(
         sliderInput("years",
                     label = "Publication year",
                     min = 1973,
                     max = 2019,
                     value = 2019
         )
      ),

      tabItems(
         tabItem("overview"),
         tabItem("citations"),
         tabItem("abstract"),
         tabItem("authors",
                 textOutput("xml")
                 )
      )

   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

   # Define a reactive expression for the document term matrix
   reactive_ids <- reactive({
      # Change when the "search" button is pressed...
      input$search
      get_ids(query = input$query)
   })



   output$xml <- renderText({
      xml <- reactive_ids() %>% get_xml()
      print(xml)
   })

}

# Run the application
shinyApp(ui = ui, server = server)

