ba_message <- function(msg = "Using local test server.") {
  stopifnot(is.character(msg))
    if (getOption("brapi_info", default = FALSE))
        return(message(msg))
}
