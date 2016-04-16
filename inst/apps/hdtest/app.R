library(d3heatmap)

library(shinyURL)
library(qtlcharts)
library(leaflet)
#library(dplyr)
library(withr)
library(DT)
library(brapi)
library(shiny)
library(shinydashboard)


source("config.R")

ui <- dashboardPage(skin = "yellow",


                    dashboardHeader(title = "HIDAP",
                                    # Dropdown menu for notifications
                                    dropdownMenuOutput("notificationMenu")

                                    ),
                    dashboardSidebar(
                      sidebarMenu(id = "tabs",
                        menuItem("About", tabName = "inf_dashboard", icon = icon("info"), selected = TRUE),
                        menuItem("Phenotype", icon = icon("leaf"),
                                 menuSubItem("Analysis",
                                             tabName = "phe_dashboard", icon = icon("calculator"))
                                 ,
                                 numericInput("fbaInput", "Fieldbook ID", 142, 1, 9999)


                        ),

                        menuItem("Environment", tabName = "env_dashboard", icon = icon("globe")


                        )
                      )
                    ),
                    dashboardBody(
                      #tags$head(tags$style(HTML(mycss))),
                      tabItems(
                        tabItem(tabName = "inf_dashboard",
                                column(width =12,
                                       tabBox(width=NULL, id="tabInfo",
                                              tabPanel("Session",
                                                       verbatimTextOutput("sessionInfo")
                                                       )
                                              )
                                       )
                                ),
                        tabItem(tabName = "env_dashboard",
                                fluidRow(
                                  column(width = 8,
                                         tabBox(width = NULL, id = "tabLocation",
                                                tabPanel("Map",
                                                         leafletOutput("mapLocs")
                                                ),
                                                tabPanel("Report",
                                                         htmlOutput("rep_loc")
                                                         #HTML("<h1>Under development!</h1>")
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
                                                ),
                                                tabPanel("Fieldtrials",
                                                            htmlOutput("site_fieldtrials")
                                                ),
                                                tabPanel("Genotypes",
                                                         htmlOutput("site_genotypes")
                                                )

                                         ) #tabbox
                                  )# column
                                ), #fluidRow


                                fluidRow(
                                  column(width = 8,
                                         box(width = NULL,
                                             title = "Location table",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             DT::dataTableOutput("tableLocs")
                                             #locationsUI("location")
                                         )
                                  )
                                )
                        ),
                        tabItem(tabName = "phe_dashboard",
                                fluidRow(
                                  column(width = 12,
                                         box(width = 8,
                                             title = "Fieldbook",
                                             #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                                             #rHandsontableOutput("hotFieldbook", height = 400)
                                             tags$div(DT::dataTableOutput("hotFieldbook", height = 400), style = "font-size:80%")
                                             #locationsUI("location")
                                         ),
                                         tabBox(width = 4,
                                            tabPanel(title = "Histogram",
                                             plotOutput("fieldbook_histogram")
                                             ),
                                            tabPanel(title = "Scatter",
                                                     div(style = "position:relative",
                                                     plotOutput("fieldbook_scatter",
                                                                hover = hoverOpts("plot_hover",
                                                                                  delay = 100,
                                                                                  delayType = "debounce")),
                                                     uiOutput('scatterplotHover_info')
                                                     )
                                            )
                                         )
                                  )

                                )
                                ,
                                fluidRow(
                                  column(width = 12,
                                         tabBox(width = NULL, selected = "Map", id = "tabAnalysis",
                                                tabPanel("Correlation",
                                                         #tags$img(src = "www/35.gif"),
                                                         div(id = "plot-container",
                                                             #tags$img(src = "www/35.gif"),

                                                             qtlcharts::iplotCorr_output('vcor_output', height = 400)
                                                         )
                                                ),
                                                tabPanel("Map",
                                                         d3heatmap::d3heatmapOutput("fieldbook_heatmap")
                                                ),
                                                tabPanel(title = "Report",
                                                    tabBox(id = "tabAnalaysis", width = NULL,
                                                      tabPanel("HTML report",
                                                               htmlOutput("fbRepHtml")
                                                               )
                                                      ,
                                                      tabPanel("Word report",
                                                               htmlOutput("fbRepWord")
                                                      ),
                                                      tabPanel("PDF report",
                                                               htmlOutput("fbRepPdf")
                                                      )

                                                      )


                                                )



                                         ),
                                         HTML("<div style='display:none'>"),
                                         shinyURL.ui(label = "",width=0, copyURL = F, tinyURL = F),
                                         #shinyURL.ui("URL", tinyURL = F)
                                         HTML("</div>")
                                  )

                                )
                        )

                      )        )
)





################


############################################################

sv <- function(input, output, session) ({

  #

  output$notificationMenu <- renderMenu({
    bh = stringr::str_split(brapi_host, "@")[[1]][2]
    note = paste0("Connect: ", bh) #session$clientData$url_hostname)
    nots <-list(notificationItem(note, status = "success"))
    dropdownMenu(type = "notifications", .list = nots)
    #nots
  })

  shinyURL.server()
  brapi::fieldbook_analysis(input, output, session)
  brapi::locations(input, output, session)
})

shinyApp(ui, sv)









