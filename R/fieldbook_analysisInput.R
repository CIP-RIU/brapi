
#' Fieldbook analysis input
#'
#' Creates a shiny based widget to collect field book analysis parameters.
#'
#' @param id text
#' @param label text
#' @import shiny
#' @author Reinhard Simon
#' @export
fieldbook_analysisInput <- function(id, label = "Fieldbook analysis parameters"){
  ns <- NS(id)
  tagList(
    shiny::numericInput(ns("fbaInput"), "Fieldbook ID", 142, 1, 9999)
  )
}
