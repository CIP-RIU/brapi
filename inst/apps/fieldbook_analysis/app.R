library(shiny)
library(brapi)
library(shinydashboard)
library(d3heatmap)
library(rhandsontable)

ui <- dashboardPage(skin = "yellow",
                    dashboardHeader(title = "HIDAP"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Phenotype",
                          menuSubItem("Analysis",
                                 tabName = "phn_dashboard", icon = icon("map-o"))
                                 ,
                                 numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)


                        )
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "phn_dashboard",
                                fluidRow(
                                  column(width = 8,
                                         tabBox(width = NULL, selected = "fieldbook_heatmap",
                                                tabPanel("Correlation",
                                                         qtlcharts::iplotCorr_output('vcor_output', height = 400)
                                                ),
                                                tabPanel("Fieldbook Map",
                                                         d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                                ),
                                                tabPanel("Report",
                                                         htmlOutput("rep_loc")

                                                )



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
                                         box(width = NULL,
                                             title = "Fieldbook",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             rHandsontableOutput("hotFieldbook", height = 400)
                                             #locationsUI("location")
                                         )
                                  )
                                )
                        )

                      )
                    )
)

############################################################

sv <- function(input, output, session) ({
  brapi::fieldbook_analysis(input, output, session)
})

shinyApp(ui, sv)

