

#' brapiConnect
#'
#' shiny server side complement
#'
#' @param input shiny input
#' @param output shiny output
#' @param session shiny session
#' @import shiny
#' @export
brapiConnect <- function(input, output, session) {

  con <- reactive({
    list(
      server = input$server,
      port = input$port,
      user = input$user,
      password = input$password
    )
  })

  return(con)

}
