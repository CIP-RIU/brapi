library(shiny)
library(brapi)
library(shinydashboard)
library(d3heatmap)
#library(rhandsontable)
library(shinyURL)

ui <- dashboardPage(skin = "yellow",
                    dashboardHeader(title = "HIDAP"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Phenotype",
                          menuSubItem("Analysis",
                                 tabName = "phn_dashboard", icon = icon("map-o"))
                                 ,
                                 numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)
                          ,
                          HTML("<div style='display:none'>"),
                          shinyURL.ui(label = "",width=0, copyURL = F, tinyURL = F),
                          #shinyURL.ui("URL", tinyURL = F)
                          HTML("</div>")


                        )
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "phn_dashboard",
                                fluidRow(
                                  column(width = 8,
                                         box(width = NULL,
                                             title = "Fieldbook",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             DT::dataTableOutput("hotFieldbook")
                                             #locationsUI("location")
                                         )
                                  )
                                  ,
                                  column(width = 4,
                                         tabBox(width = NULL, title = "Site",
                                                tabPanel("Histogram",
                                                         plotOutput("histogram")
                                                ),
                                                tabPanel("Info",
                                                         htmlOutput("siteInfo")
                                                ), tabPanel("Fieldtrials",
                                                            htmlOutput("site_fieldtrials")
                                                ),
                                                tabPanel("Genotypes",
                                                         htmlOutput("site_genotypes")
                                                )

                                         )
                                  )
                                )
                                ,
                                fluidRow(
                                  column(width = 12,
                                         tabBox(width = NULL, selected = "Map", id = "tabAnalysis",
                                                tabPanel("Correlation",
                                                         qtlcharts::iplotCorr_output('vcor_output', height = 400)
                                                ),
                                                tabPanel("Map",
                                                         d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                                ),
                                                tabPanel(title = "Report",
                                                         #htmlOutput("fb_report")
                                                         htmlOutput("fbRep")

                                                )



                                         )
                                  )

                                )
                        )

                      )
                    )
)

############################################################

sv <- function(input, output, session) ({
  shinyURL.server()
  brapi::fieldbook_analysis(input, output, session)
})

shinyApp(ui, sv)

