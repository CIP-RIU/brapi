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
                                    uiOutput("sitesReport")
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

    dat <- reactive({
      callModule(locations, "locationsData")
    })

    dat_sel <- reactive({
      sel = input$table_rows_all
      if(is.null(sel)){
        pts = dat()
      } else {
        pts = dat()[sel, ]
      }
      pts
    })

    output$table <- DT::renderDataTable(dat(), server = FALSE)

    output$map <- renderLeaflet({
      pts <- dat_sel()

      leaflet(pts, height = "100%") %>% addTiles() %>%
        addMarkers(clusterOptions = markerClusterOptions(clickable = T)) %>% fitBounds(
          ~min(longitude), ~min(latitude),
          ~max(longitude), ~max(latitude)
        )


    })

    observeEvent(input$done, {
      out = (locs = dat())
      #TODO how to return selected list of locs?
       stopApp("Bye!")
    })


    # download the filtered data
    output$locsDL = downloadHandler('BRAPI-locs-filtered.csv', content = function(file) {
      write.csv(dat_zel(), file)
    })


    output$histogram <- renderPlot({
      hist(dat()$altitude, main = "Frequency of altitude of breeding locations.",
           xlab = "altitude [m]", sub = "Selected location frequencies are in red.")
      hist(dat_sel()$altitude, add = T, col = "red")
      if(length(mrks()) > 0){
        # print("abline")
        # print(mrks()$altitude)
        abline(v = mrks()$altitude, col="blue", lwd = 5)
      }
    })

    ##################################

    mrks <- reactive({
      x = input$map_marker_click
      subset(dat_sel(), latitude == as.numeric(x$lat) & longitude == as.numeric(x$lng))
    })

    rec2info <- function(rec){
      #rec %>% as.data.frame
      nms = names(rec)
      dat = t(rec)
      dat = cbind(nms, dat)
      #rint(str(dat))
      # print(nrow(dat))
      row.names(dat) = 1:nrow(dat)
      colnames(dat) = c("Attribute", "Value")
      dat = dat[c(1, 5, 9, 4, 3, 2, 6, 7, 8, 10, 12, 13, 14, 11), ]
      x = htmlTable::htmlTable(dat)
      paste0("<center>", x, "</center>") %>% HTML
    }

    observe({
      rec = mrks()
      if (nrow(rec)==1) {
        output$siteInfo <- renderUI({
          #str(rec) %>% paste %>% print
          rec2info(rec)
        })
      } else {
        output$siteInfo = renderPrint({
          ""
        })
      }

    })



  }

  viewer <- paneViewer(300)

  runGadget(ui, server, viewer = viewer)


}
