brapiGET <- function(url, format = "json", con = NULL) {
  ba_message(msg = paste0("URL call was: ", url, "\n"))
  res <- httr::GET(url = url,
                   httr::add_headers( "Authorization" = paste("Bearer", con$token)))
  txt <- ifelse(res$status == 200, " ok!", " problem!")
  ba_message(msg = paste0("Server status: ", txt, "\n"))
  tryCatch({
    if (is.ba_status_ok(resp = res)) {
      out <- httr::content(x = res, as = "text", encoding = "UTF-8")
      # Get metadata
        x <- jsonlite::fromJSON(txt = out)
        # TODO test if 'metadata' slot exists
        if (exists('metadata', where = x)) {
          lst <- x$metadata$status
          #Check if status object has any key-value pairs
          info <- ifelse(exists("info", where = lst), paste(lst$info[!is.na(lst$info)], collapse = "\n\r"), "")
          success<- ifelse(exists("success", where = lst), paste(lst$success[!is.na(lst$success)], collapse = "\n\r"), "")
          error<- ifelse(exists("error", where = lst), paste(lst$error[!is.na(lst$error)], collapse = "\n\r"), "")
          msg <- list(info = info, success = success, error = error)
          show_server_status_messages(msg)
        }
    }
  }, error = function(e) stop(paste0(e, "\n\nMalformed request.")))
  return(res)
}
