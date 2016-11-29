#' mock
#'
#' Starts a mock BrAPI server intended for local testing of brapi calls.
#'
#' @export
mock_server <- function(){
  fp <- system.file("apps/brapi/server.R", package = "brapi")
  source(fp)
}
