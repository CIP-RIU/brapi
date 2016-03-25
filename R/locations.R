
#' locations
#'
#' @param input shiny
#' @param output shiyn
#' @param session shiny
#' @import shiny
#' @author Reinhard Simon
#' @return data.frame
#' @export
locations <- function(input, output, session){
  dataframe <- reactive({
    brapi::locations_list()
  })

  return(dataframe)
}
