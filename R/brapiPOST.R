brapiPOST <- function(url, body, con = con) {
  ba_message(msg = paste0("URL call was: ", url, "\n"))
  ba_message(msg = paste0("Waiting for response from server: ...\n"))

  res <- httr::POST(url = url, body = body, encode = "json",
        httr::add_headers( "Authorization" = paste("Bearer", con$token)))

  txt <- ifelse(res$status == 200, " ok!", " problem!")
  ba_message(msg = paste0("Server status: ", txt, "\n"))
  out <- httr::content(res)
  show_server_status_messages(out)
  return(res)
}
