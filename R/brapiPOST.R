brapiPOST <- function(url, body, con = con){
  res <- httr::POST(url, body = body, encode = "json",
                    httr::add_headers("X-AUTH-TOKEN" = con$token))
  txt <- ifelse(res$status_code == 200, " (ok)!", " (error)!" )
  message_brapi(paste0("Server status: ", res$status_code, txt, "\n"))

  # TODO: Insert here status messages if any!
  out <- httr::content(res, "text", encoding = "UTF-8")
  # Get JSON
  out <- jsonlite::fromJSON(out)$metadata$status
  # Check if status object has any key-value pairs
  n <- nrow(out)
  if (!is.null(n)) {
  if (n > 0) {
    # if so: cycle through and print a message for each!
    for(i in 1:n) {
      msg <- paste0("Warning code -> ", out[i, "code"], ": ", out[i, "message"], "")
      message_brapi(msg)
    }
  }
  }


  res
}
