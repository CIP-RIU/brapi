
#library(shiny)
#library(miniUI)

brapiConnectAddin <- function(){

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("BrAPI"),
    miniUI::miniContentPanel(
      brapiConnectInput("brapi")
    )

  )

  server <- function(input, output, session) {
    con <- shiny::callModule(brapiConnect, "brapi")


    shiny::observeEvent(input$done, {
      dtl <- unlist(con())
      Sys.setenv(BRAPI_SESSION = "")
      #cat(str(dtl))
      try({
        Sys.setenv(BRAPI_LOGIN = paste0(dtl[["user"]],":", dtl[["password"]]))

        prt <- (dtl[["port"]] %>% as.integer)
        brapi::set_brapi(dtl[["server"]], prt)
        brapi::brapi_auth(dtl[["user"]], dtl[["password"]])
        cat("Connection refreshed!")
       })
      stopApp()
    })

  }

  viewer <- shiny::paneViewer(300)

  shiny::runGadget(ui, server, viewer = viewer)

}
