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
              ),
              fluidRow(
                column(width = 12,
                  box(width = NULL,
                    title = "Location table",
                    #p(class = 'text-center', downloadButton('locsDL', 'Download Filtered Data')),
                    DT::dataTableOutput("table")
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
   brapi::locations(input, output, session)
})

shinyApp(ui, sv)

