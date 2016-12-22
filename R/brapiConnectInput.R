get_brapi_session_file <- function(){
  file.path(fbglobal::get_base_dir("brapi"), "brapi_session.rda")
}

#' BrAPI Connect
#'
#' Creates a shiny based widget to collect connection data.
#'
#' @param id text
#' @param label text
#' @import shiny
#' @import stringr
#' @author Reinhard Simon
#' @export
brapiConnectInput <- function(id, label = "Connect to BrAPI database"){
  ns <- NS(id)

  fp = get_brapi_session_file()

  if (is.null(brapi)){#} | (brapi$user == "rs" & brapi$pwd == "pwd")) {
    if(file.exists(fp)) {
      brapi <<- readRDS(fp)
    }
  }

  #TODO adjust to new brapi connection details with several crops!
  tagList(
    shiny::selectInput(ns("crop"), "Crop", choices = brapi$crop, selected = brapi$crop),
    shiny::selectInput(ns("protocol"), "Protocol", choices = c("https://", "http://")),
    shiny::textInput(ns("server"), label, value = brapi$db, width = '100%'),
    shiny::numericInput(ns("port"), "Port",value = brapi$port , 0, 9999),
    shiny::textInput(ns("user"), "User", value = brapi$user, placeholder = "User name"),
    shiny::passwordInput(ns("password"), "Password", value = brapi$pwd),
    shiny::checkboxInput(ns("session_save"), "Save session?", TRUE)
  )
}
