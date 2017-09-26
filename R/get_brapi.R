# Retrieve the url where BrAPI has been implemented
get_brapi <- function(brapi = NULL) {
  if (is.null(brapi)) return(NULL)
  if (!is.null(brapi$apipath)) {
    brapi$apipath <- paste0("/", brapi$apipath)
  }
  if (brapi$secure) {
    brapi$protocol <- "https://"
  }
  port <- ifelse(brapi$port == 80 || brapi$port == 8080, "", paste0(":", brapi$port))
  if (brapi$multicrop) {
    url <- paste0(brapi$protocol, brapi$db, port, brapi$apipath, "/", brapi$crop, "/brapi/v1/")
  } else {
    url <- paste0(brapi$protocol, brapi$db, port, brapi$apipath, "/brapi/v1/")
  }
  return(url)
}
