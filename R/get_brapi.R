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

  version <- ifelse("version" %in% names(con), con$version, "v1")

  brapi_version <- paste0("/brapi/", version, "/")

  if (con$multicrop) {
    url <- paste0(con$protocol, con$db, port, con$apipath, "/",
                  con$crop, brapi_version)
  } else {
    url <- paste0(con$protocol, con$db, port, con$apipath,
                  brapi_version)
  }
  return(url)
}
