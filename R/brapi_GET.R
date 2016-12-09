brapiGET <- function(url){
  res <- httr::GET(url)
  txt <- ifelse(res$status == 200, " (ok)!", " (error)!" )
  message_brapi(paste0("Server status: ", res$status, txt, "\n"))

  # TODO: Insert here status messages if any!
  out <- httr::content(res, "text", encoding = "UTF-8")
  # Get JSON
  # Check if status object has any key-value pairs
  # if so: cycle through and print a message for each!

  res
}
