

#' brapiConnect
#'
#' shiny server side complement
#'
#' @param input shiny input
#' @param output shiny output
#' @param session shiny session
#' @export
brapiConnect <- function(input, output, session) {

  con <- reactive({
    list(
      crop = input$crop,
      server = input$server,
      port = input$port,
      user = input$user,
      password = input$password,
      session_save = input$session_save
    )
  })

  return(con)

}
