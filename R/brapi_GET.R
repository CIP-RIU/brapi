brapiGET <- function(url){
  res <- httr::GET(url)
  txt <- ifelse(res$status == 200, " (ok)!", " (error)!" )
  message_brapi(paste0("Server status: ", res$status, txt, "\n"))
  res
}
