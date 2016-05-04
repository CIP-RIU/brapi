library(shiny)
library(miniUI)
library(ggplot2)
library(leaflet)

locationsAddin <- function(){
  ui <- miniPage(
    gadgetTitleBar("Locations"),
    miniTabstripPanel( selected = "Map",
      miniTabPanel("Data", icon = icon("table"),
        miniContentPanel(
          #locationsUI("locations")
          p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
          DT::dataTableOutput("table")
        )
      ),
      miniTabPanel("Map", icon = icon("map-o"),
                   miniContentPanel(padding = 0,
                                    leaflet::leafletOutput("map", height = "100%")
                   )
      ),
      miniTabPanel("Histogram", icon = icon("bar-chart"),
                   miniContentPanel(padding = 0,
                                    plotOutput("histogram")
                   )
      ),
      miniTabPanel("Single site info", icon = icon("info"),
                   miniContentPanel(padding = 0,
                                    htmlOutput("siteInfo")
                   )
      ),
      miniTabPanel("Site group report", icon = icon("book"),
                   miniContentPanel(padding = 0,
                                    htmlOutput("rep_loc")
                   )
      ),
      miniTabPanel("Trial per site", icon = icon("info"),
                   miniContentPanel(padding = 0,
                                    htmlOutput("site_fieldtrials")
                   )
      ),
      miniTabPanel("Genotypes per site", icon = icon("info"),
                   miniContentPanel(padding = 0,
                                    htmlOutput("site_genotypes")
                   )
      ),
      miniTabPanel("Site scatter chart", icon = icon("line-chart"),
                   miniContentPanel(padding = 0,
                                    uiOutput("sitesScatter")
                   )
      )
    )

  )

  ##################################

  server <- function(input, output, session) {

    brapi::locations(input, output, session)

    observeEvent(input$done, {
      stopApp("Bye!")
    })

  }

  viewer <- paneViewer(300)

  runGadget(ui, server, viewer = viewer)


}
