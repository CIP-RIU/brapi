library(shiny)
library(miniUI)
#library(rhandsontable)
library(DT)
library(ggplot2)
library(d3heatmap)
library(qtlcharts)
library(agricolae)


fieldbook_analysisAddin <- function(){
  ui <- miniPage(
    gadgetTitleBar("Fieldbook Analysis"),
    miniTabstripPanel( selected = "Field Map",
                       miniTabPanel("Parameters", icon = icon("list-alt"),
                                    miniContentPanel(padding = 0,
                                      #fieldbook_analysisInput("fb")
                                      numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)
                                    )
                       ),
                       miniTabPanel("Data", icon = icon("table"),
                                    miniContentPanel(padding = 0,
                                      DT::dataTableOutput("hotFieldbook")
                                    )
                       ),
                       miniTabPanel("Correlations", icon = icon("line-chart"),
                                    miniContentPanel(padding = 0,
                                      qtlcharts::iplotCorr_output("vcor_output")
                                    )
                       )
                       ,


                       miniTabPanel("Field Map", icon = icon("map-o"),
                                    miniContentPanel(padding = 0,
                                      d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                      )
                       ),



                       miniTabPanel("Fieldbook report", icon = icon("book"),
                                    miniContentPanel(padding = 0
                                                     ,
                                                     uiOutput("fbRep")
                                    )
                       )
    )

  )

  ##################################

  server <- function(input, output, session) {
    #brapi::locations(input, output, session)
    brapi::fieldbook_analysis(input, output, session)

    observeEvent(input$done, {

      fieldbook <- brapi::study_table(input$fbaInput)
      attr(fieldbook, "fieldbookId") = input$fbaInput
      hidap_fieldbook <<- fieldbook

      msg = c("The fieldbook is available in your session",
              "through the variable:",
              "",
             "'hidap_fieldbook'!",
             "",
             "Bye!"
      )


      stopApp(msg)
    })

  }

  viewer <- paneViewer(300)

  runGadget(ui, server, viewer = viewer)
}
