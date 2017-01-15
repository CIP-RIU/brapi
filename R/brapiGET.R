brapiGET <- function(url, format = "json", con = NULL) {
    message_brapi(paste0("URL call was: ", url, "\n"))
    res <- httr::GET(url, httr::add_headers(`X-AUTH-TOKEN` = con$token))
    txt <- ifelse(res$status == 200, " ok!", " problem!")
    message_brapi(paste0("Server status: ", txt, "\n"))

    if (is.status_ok(res)) {
        out <- httr::content(res, "text", encoding = "UTF-8")
        # Get JSON
        if (format == "json") {
            out <- jsonlite::fromJSON(out)$metadata$status
            # Check if status object has any key-value pairs
            n <- nrow(out)
            if (!is.null(n)) {
                if (n > 0) {
                  # if so: cycle through and print a message for each!
                  message_brapi("Status messages")
                  for (i in 1:n) {
                    msg <- paste0("BrAPI server: ", out[i, "code"], ": ",
                                  out[i, "message"], "")
                    message_brapi(msg)
                  }
                }
            }
        }
    }
    res
}
