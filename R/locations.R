
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
  datf <- reactive({
    brapi::locations_list()
  })
  dat = datf()

  dat = dat[!is.na(dat$latitude), ]

  return(dat)
}
