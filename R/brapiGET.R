brapiGET <- function(url, format = "json", con = NULL) {
    ba_message(paste0("URL call was: ", url, "\n"))
    res <- httr::GET(url, httr::add_headers(`X-AUTH-TOKEN` = con$token))
    txt <- ifelse(res$status == 200, " ok!", " problem!")
    ba_message(paste0("Server status: ", txt, "\n"))

    if (is.ba_status_ok(res)) {
        out <- httr::content(res, "text", encoding = "UTF-8")
        # Get JSON
        if (format == "json") {
            out <- jsonlite::fromJSON(out)$metadata$status
            # Check if status object has any key-value pairs
            show_server_status_messages(out)
        }
    }
    return(res)
}
