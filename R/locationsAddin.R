library(shiny)
library(miniUI)
library(leaflet)
library(ggplot2)

locationsAddin <- function(){
  ui <- miniPage(
    gadgetTitleBar("Locations"),
    miniTabstripPanel( selected = "Map",
      miniTabPanel("Data", icon = icon("table"),
        miniContentPanel(
          #locationsUI("locations")
          DT::dataTableOutput("table")
        )
      ),
      miniTabPanel("Map", icon = icon("map-o"),
                   miniContentPanel(padding = 0,
                                    leafletOutput("map", height = "100%")
                   ),
                   miniButtonBlock(
                     actionButton("resetMap", "Reset")
                   )
      )
    )

  )

  server <- function(input, output, session) {

    dat <- reactive({
      dataFrame <- callModule(locations, "locationsData")
      dat = dataFrame()
      dat = dat[!is.na(dat$latitude), ]
      dat
    })

    output$table <- DT::renderDataTable(dat(), server = FALSE)

    output$map <- renderLeaflet({
      sel = input$table_rows_all
      if(is.null(sel)){
        pts = dat()
      } else {
        pts = dat()[sel, ]
      }

      leaflet(pts, height = "100%") %>% addTiles() %>%
        addMarkers(clusterOptions = markerClusterOptions()) %>% fitBounds(
          ~min(longitude), ~min(latitude),
          ~max(longitude), ~max(latitude)
        )
    })

    observeEvent(input$done, {
      out = (locs = dat())
      #TODO how to return selected list of locs?
       stopApp("Bye!")
    })

    eventReactive(input$resetMap, {
      leafletProxy("map", data = dat()) %>% fitBounds(
        ~min(longitude), ~min(latitude),
        ~max(longitude), ~max(latitude)
      )
    })

  }

  viewer <- paneViewer(300)

  runGadget(ui, server, viewer = viewer)


}
