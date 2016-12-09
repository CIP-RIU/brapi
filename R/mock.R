#' mock
#'
#' Starts a mock BrAPI server intended for local testing of brapi calls.
#'
#' @family utility
#' @export
mock_server <- function(){
  fp <- system.file("apps/brapi/server.R", package = "brapi")
  source(fp)
}
