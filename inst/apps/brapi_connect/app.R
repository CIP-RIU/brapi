#library(shiny)
library(brapi)

ui <- fixedPage(
      brapiConnectInput("brapi")
)

server <- function(input, output, session) {
  callModule(brapiConnect, "BrAPI DB")
}

shinyApp(ui, server)
