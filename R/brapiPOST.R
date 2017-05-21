brapiPOST <- function(url, body, con = con) {
  ba_message(msg = paste0("URL call was: ", url, "\n"))
  res <- httr::POST(url = url, body = body, encode = "json", httr::add_headers(`X-AUTH-TOKEN` = con$token))
  txt <- ifelse(res$status_code == 200, " (ok)!", " (error)!")
  ba_message(msg = paste0("Server status: ", res$status_code, txt, "\n"))
  if (is.ba_status_ok(res)) {
    out <- httr::content(x = res, as = "text", encoding = "UTF-8")
    # Get JSON
    x <- jsonlite::fromJSON(txt = out)
    # TODO test if 'metadata' slot exists
    if ("metadata" %in% names(x)) {
      out <- x$metadata$status
      # Check if status object has any key-value pairs
      show_server_status_messages(out = out)
    }
  }
  return(res)
}
