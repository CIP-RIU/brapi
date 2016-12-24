#' mock
#'
#' Starts a mock BrAPI server intended for local testing of brapi calls.
#' @param port integer; default 2021
#' @family utility
#' @export
mock_server <- function(port = 2021){
  # port = ifelse(is.integer(port), port, 2021)
  # server(port, daemonized = TRUE)
  fp <- system.file("apps/brapi/server.R", package = "brapi")
  source(fp)
}
