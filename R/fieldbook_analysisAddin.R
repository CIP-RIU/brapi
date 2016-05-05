#library(shiny)
library(miniUI)
#library(rhandsontable)
library(DT)
library(ggplot2)
library(d3heatmap)
library(qtlcharts)
library(agricolae)


fieldbook_analysisAddin <- function(fieldbook = NULL){
  if(is.null(fieldbook)){
    #print("no fieldbook passed in!")
  }
  hidap_fieldbook <- NULL

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Fieldbook Analysis"),
    miniUI::miniTabstripPanel( selected = "Field Map",
                               miniUI::miniTabPanel("Parameters", icon = icon("list-alt"),
                                                    miniUI::miniContentPanel(padding = 0,
                                      #fieldbook_analysisInput("fb")
                                      shiny::numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)
                                    )
                       ),
                       miniUI::miniTabPanel("Data", icon = icon("table"),
                                            miniUI::miniContentPanel(padding = 0,
                                      DT::dataTableOutput("hotFieldbook")
                                    )
                       ),
                       miniUI::miniTabPanel("Correlations", icon = icon("line-chart"),
                                            miniUI::miniContentPanel(padding = 0,
                                      qtlcharts::iplotCorr_output("vcor_output")
                                    )
                       )
                       ,


                       miniUI::miniTabPanel("Field Map", icon = icon("map-o"),
                                            miniUI::miniContentPanel(padding = 0,
                                      d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                      )
                       ),



                       miniUI::miniTabPanel("Fieldbook report", icon = icon("book"),
                                            miniUI::miniContentPanel(padding = 0
                                                     ,
                                                     shiny::uiOutput("fbRep")
                                    )
                       )
    )

  )

  ##################################

  server <- function(input, output, session) {
    #brapi::locations(input, output, session)
    brapi::fieldbook_analysis(input, output, session)

    observeEvent(input$done, {

      hidap_fieldbook <<- brapi::study_table(input$fbaInput)

      msg = c("The fieldbook is available in your session",
              "through the variable:",
              "",
             "'hidap_fieldbook' (see the metadata for details)!",
             "",
             attr(hidap_fieldbook, "meta")$studyName,
             "",
             "Bye!"
      )


      stopApp(msg)
    })

  }

  viewer <- paneViewer(300)

  runGadget(ui, server, viewer = viewer)
}
