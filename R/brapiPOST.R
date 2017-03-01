brapiPOST <- function(url, body, con = con) {
   ba_message(paste0("URL call was: ", url, "\n"))
    res <- httr::POST(url, body = body, encode = "json",
                      httr::add_headers(`X-AUTH-TOKEN` = con$token))
    txt <- ifelse(res$status_code == 200, " (ok)!", " (error)!")
    ba_message(paste0("Server status: ", res$status_code, txt, "\n"))

    if (is.ba_status_ok(res)) {
        out <- httr::content(res, "text", encoding = "UTF-8")
        # Get JSON
        out <- jsonlite::fromJSON(out)$metadata$status
        # Check if status object has any key-value pairs
        show_server_status_messages(out)
    }
    return(res)
}
