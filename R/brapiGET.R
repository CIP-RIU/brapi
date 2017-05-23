brapiGET <- function(url, format = "json", con = NULL) {
  ba_message(paste0("URL call was: ", url, "\n"))
  res <- httr::GET(url = url, httr::add_headers(`X-AUTH-TOKEN` = con$token))
  txt <- ifelse(res$status == 200, " ok!", " problem!")
  ba_message(msg = paste0("Server status: ", txt, "\n"))
  tryCatch({
    if (is.ba_status_ok(resp = res)) {
      out <- httr::content(x = res, as = "text", encoding = "UTF-8")
      # Get JSON
      # if (format == "json") {
      #   # x <- jsonlite::fromJSON(txt = out)
      #   # TODO test if 'metadata' slot exists
      #   # if (exists('metadata', where = x)) {
      #   #   out <- x$metadata$status
      #   #   Check if status object has any key-value
      #   #   pairs show_server_status_messages(out)
      #   # }
      # }
    }
  }, error = function(e) stop(paste0(e, "\n\nMalformed request.")))
  return(res)
}
