# Retrieve the url where BrAPI has been implemented
get_brapi <- function(con = NULL) {
  if (is.null(con)) return(NULL)
  if (!is.null(con$apipath)) {
    con$apipath <- paste0("/", con$apipath)
  }
  if (con$secure) {
    con$protocol <- "https://"
  }
  port <- ifelse(con$port == 80, "", paste0(":", con$port))
  if (con$multicrop) {
    url <- paste0(con$protocol, con$db, port, con$apipath, "/", con$crop, "/brapi/v1/")
  } else {
    url <- paste0(con$protocol, con$db, port, con$apipath, "/brapi/v1/")
  }
  return(url)
}
