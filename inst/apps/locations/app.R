library(shiny)
library(brapi)
library(shinydashboard)


ui <- dashboardPage(skin = "yellow",
  dashboardHeader(title = "HIDAP"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Environment", tabName = "env_dashboard", icon = icon("map-o")


               )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "env_dashboard",
              fluidRow(
                column(width = 8,
                       tabBox(width = NULL,
                           tabPanel("Map",
                             leafletOutput("map")
                             ),
                           tabPanel("Table",

                              DT::dataTableOutput("table")
                            )
                       ),
                       box(width = NULL,
                           title = "Location summary report",
                           #actionButton("locs_report_button", "Do report!"),
                           htmlOutput("rep_loc_docs"),
                           #htmlOutput("rep_loc_docx"),
                           htmlOutput("rep_loc"))
                       )


                ,
                column(width = 4,
                       tabBox(width = NULL, title = "Site",
                              tabPanel("Info",
                                       verbatimTextOutput("siteInfo")
                              ), tabPanel("Fieldtrials",
                                          htmlOutput("site_fieldtrials")
                              ),
                              tabPanel("Genotypes",
                                       htmlOutput("site_genotypes")
                              )
                       ),

                       box(width = NULL,
                           plotOutput("histogram"))

                )
              )
      )

  )
)
)

############################################################

sv <- function(input, output, session) ({
  dat <- reactive({
    dataFrame <- callModule(locations, "locationsData")
    dat = dataFrame()
    dat = dat[!is.na(dat$latitude), ]
    dat
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

  output$table <- DT::renderDataTable({
    DT::datatable(dat())
    }, server = FALSE)

  output$map <- renderLeaflet({
    pts <- dat_sel()

    leaflet(pts, height = "100%") %>% addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions(clickable = T)) %>% fitBounds(
        ~min(longitude), ~min(latitude),
        ~max(longitude), ~max(latitude)
      )


  })

  locsInBounds <- reactive({
    lib <- input$map_bounds
    lib %>% print
    lib
  })

  # output$siteInfo <- renderText({
  #   locsInBounds() %>% paste0
  # })

  observe({
    leafletProxy("map") %>% clearPopups()
    event <- input$map_marker_click
    if (is.null(event)) {
      #print("no data")
      print(event)
      return()
    }


    isolate({
      output$siteInfo <- locsInBounds() %>% paste0
    })
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
  })

  ##################################



  # observeEvent(input$map_env_marker_click, {
  #   input$map_env_marker_click %>% print
  #
  # })
  #
  # loc_info <- eventReactive(input$map_marker_click, {
  #   event <- input$map_marker_click
  #   print(event)
  #   # msg <- values[["map_msg"]]
  #   #
  #   # rec <- subset(locs,
  #   #               LATD == as.numeric(event$lat) & LOND == as.numeric(event$lng))
  #   #if(nrow(rec) != 1) return("No location selected.")
  #   #rec = rec[1:(ncol(rec))]
  #   #paste(names(rec),": ", rec, "<br/>", sep="")
  #   #"Do get the fieldtrial list!"
  #   #paste(fbmaterials::get_genotype_list_by_loc(rec$SHORTN), collapse = ", ")
  #   paste(event)
  # }, ignoreNULL = FALSE)
  #
  # output$siteInfo <- renderText ({
  #   loc_info()
  # })

  # observe({
  #   click<-input$map_marker_click
  #   if(is.null(click))
  #     return()
  #
  #   text2<-paste("You've selected point ", click$id)
  #   output$siteInfo<-renderText({
  #     text2
  #   })
  # })


  # mrks <- reactive({
  #   x = input$map_marker_click
  #   x
  # })
  # #
  # # output$siteInfo <- renderPrint({
  # #   mrks() %>% print
  # # })
  #
  # observe({
  #   mrks() %>% print
  # })



})

shinyApp(ui, sv)

