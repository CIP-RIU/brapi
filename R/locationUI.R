
#' locationsUI
#'
#' @param id shiny ID
#' @import shiny
#' @author Reinhard Simon
#' @return list
#' @export
locationsUI <- function(id){
  ns <- NS(id)

  tagList(
    DT::dataTableOutput(ns("table"))
  )

}
