

#' BrAPI Connect
#'
#' Creates a shiny based widget to collect connection data.
#'
#' @param id text
#' @param label text
#' @import shiny
#' @author Reinhard Simon
#' @export
brapiConnectInput <- function(id, label = "Connect to BrAPI database"){
  ns <- NS(id)

  bci = get_brapi()
  bci = stringr::str_split(bci, ":")[[1]]
  srv = bci[1]
  prt = stringr::str_split(bci[2], "/")[[1]][1]

  # lgn = Sys.getenv(("BRAPI_LOGIN"))
  # if(lgn != "") {
  #   usr = stringr::str_split(lgn, ":")[[1]][1]
  #   pwd = stringr::str_split(lgn, ":")[[1]][2]
  # } else {
  #   pwd = ""
  #   usr = ""
  # }
  pwd = ""
  usr = ""

  tagList(
    shiny::textInput(ns("server"), label, value = srv),
    shiny::numericInput(ns("port"), "Port", prt, 0, 9999),
    shiny::textInput(ns("user"), "User", value = usr, placeholder = "User name"),
    shiny::passwordInput(ns("password"), "Password", value = pwd)
  )
}
