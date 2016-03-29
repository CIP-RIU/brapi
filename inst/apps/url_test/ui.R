# http://stackoverflow.com/questions/25306519/shiny-saving-url-state-subpages-and-tabs

library(shiny)

hashProxy <- function(inputoutputID) {
  div(id=inputoutputID,class=inputoutputID,tag("div",""));
}

# Define UI for shiny d3 chatter application
shinyUI(navbarPage('URLtests', id="page", collapsable=TRUE, inverse=FALSE,
                   tabPanel("Alfa Bravo",
                            tabsetPanel(
                              ###
                              id='alfa_bravo_tabs', # you need to set an ID for your tabpanels
                              ###
                              tabPanel("Charlie",
                                       tags$p("Nothing to see here. Everything is in the 'Delta Foxtrot' 'Hotel' tab")
                              )
                            )
                   )
                   ,tabPanel("Delta Foxtrot",
                             tabsetPanel(
                               ###
                               id='delta_foxtrot_tabs', # you need to set an ID for your tabpanels
                               ###
                               tabPanel("Golf",
                                        tags$p("Nothing to see here. Everything is in the 'Delta Foxtrot' 'Hotel' tab")
                               )
                               ,tabPanel("Hotel", id='hotel',

                                         tags$p("This widget is a demonstration of how to preserve input state across sessions, using the URL hash."),
                                         selectInput("beverage", "Choose a beverage:",
                                                     choices = c("Tea", "Coffee", "Cocoa")),
                                         checkboxInput("milk", "Milk"),
                                         sliderInput("sugarLumps", "Sugar Lumps:",
                                                     min=0, max=10, value=3),
                                         textInput("customer", "Your Name:"),
                                         #includeHTML("URL.js"),
                                         ###
                                         includeHTML('url_handler.js'), # include the new script
                                         ###
                                         h3(textOutput("order")),
                                         hashProxy("hash")
                               )
                             )
                   )
))
