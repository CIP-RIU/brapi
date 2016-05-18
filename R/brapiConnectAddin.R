#' brapiConnectAddin
#'
#' Provides a form to connect to a BrAPI compatible database.
#'
#'
#' @author Reinhard Simon
#' @family addins
#' @export
#'
#' @example /inst/examples/brapiConnectAddin.R
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
      #Sys.setenv(BRAPI_SESSION = "")
      brapi$session <<- ""
      #cat(str(dtl))
      try({
        #Sys.setenv(BRAPI_LOGIN = paste0(dtl[["user"]],":", dtl[["password"]]))
        brapi$crop <<- dtl[["crop"]]
        brapi$db <<- dtl[["server"]]
        brapi$port <<- dtl[["port"]] %>% as.numeric
        brapi$user <<- dtl[["user"]]
        brapi$pwd <<- dtl[["password"]]

        #prt <- (dtl[["port"]] %>% as.integer)
        brapi::set_brapi(dtl[["server"]], brapi$port)
        brapi::brapi_auth(dtl[["user"]], dtl[["password"]])

        if(dtl[["session_save"]]){
          save(brapi, file = "brapi_session.rda")
          cat("Session connection data saved to: 'brapi_session.rda'!\n\n")
        }


        cat("Connection refreshed!")
       })

      stopApp()
    })

    shiny::observeEvent(input$cancel, {
      stopApp("Addin cancelled. No changes made.\n\n")
    })

  }

  viewer <- shiny::paneViewer(300)

  shiny::runGadget(ui, server, viewer = viewer)

}
