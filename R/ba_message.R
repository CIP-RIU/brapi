ba_message <- function(msg = "Using local test server.") {
  stopifnot(is.character(msg))
  # # This will never return a message getOption extracts a global option
  # # getOption(x = "brapi_info") will be NULL unless set via options(...)
  # # therefore the default = FALSE will almost always break the if function
  # # and the return function is not executed
  # if (getOption(x = "brapi_info", default = FALSE)) {
  #   return(message(msg))
  # }
  return(message(msg))
}
