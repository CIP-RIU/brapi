message_brapi <- function(msg = "Using local test server.") {
    # if(is_mock() & getOption('brapi_info', default = FALSE))
    if (getOption("brapi_info", default = FALSE)) 
        message(msg)
}
