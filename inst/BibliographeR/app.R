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



# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "purple",

   dashboardHeader(title = "BibliographeR"),

   dashboardSidebar(
      textInput("keywords", "Enter you keywords as in the NCBI webpage :"),
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
      )

   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application
shinyApp(ui = ui, server = server)

