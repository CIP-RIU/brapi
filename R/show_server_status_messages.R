show_server_status_messages <- function(out) {
    n <- nrow(out)
    if (!is.null(n)) {
        if (n > 0) {
            # if so: cycle through and print a message for each!
            ba_message("Status messages")
            for (i in 1:n) {
                msg <- paste0("BrAPI server warning code -> ", out[i, "code"], ": ", out[i, "message"], "")
                ba_message(msg)
            }
        }
    }
}
