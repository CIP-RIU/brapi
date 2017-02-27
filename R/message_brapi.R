message_brapi <- function(msg = "Using local test server.") {
    if (getOption("brapi_info", default = FALSE))
        return(message(msg))
}
