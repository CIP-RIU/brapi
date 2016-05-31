check_id <- function(id) {
  stopifnot(!is.null(id), !is.na(id))
  id = as.integer(id)
  stopifnot(is.integer(id))
  stopifnot(id > 0)

}


get_page <- function(query, page, pageSize) {
  rsp <- brapi_GET(paste0(query, "&pageSize=",pageSize,"&page=", page, "&"))
  httr::content(rsp)
}

assign_item <- function(avar, from, type = "character") {
  val = from[[avar]]
  to = NA
  if (!is.null(val)) {
    if(type == "character") {
      to = val
    }
    if(type == "integer") {
      to = val %>% as.integer()
    }
    if(type == "numeric") {
      to = val %>% as.numeric()
    }
    if(type == "double") {
      to = val %>% as.numeric()
    }
  }
  to
}

#' get BRAPI
#'
#' Get the current URL to a BRAPI compliant database in use locally.
#'
#' @return string
#' @author Reinhard Simon
#' @export
get_brapi <- function() {
  #Sys.getenv('BRAPI_DB')
  if(brapi$port == 80 | brapi$port == 8080) {
    url = paste0(brapi$db, "/brapi/v1/")
  } else {
    url = paste0(brapi$db, ":", brapi$port, "/brapi/v1/" )
  }

  url
}

#' set BRAPI database
#'
#' Define which BRAPI database to use for this session.
#' Leading 'http://' and trailing '/' will be removed.
#'
#' @param url string a URL to a local or remote BRAPI compliant database
#' @param port integer number
#' @author Reinhard Simon
#' @return no returned value
#' @export
set_brapi <- function(url, port=3000) {

  db = stringr::str_extract(url, "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}")
  if(stringr::str_detect(url,"http:")){
    db = url
  }
  if(port != -1){
    db = paste0(db,":", port, "/brapi/v1/")
  } else {
    db = paste0(db, "/brapi/v1/")
  }

  brapi$db <<- url
  brapi$port <<- port

  #BRAPI_DB <<- db
  #Sys.setenv(BRAPI_DB = db)
}

brapi_session <- function() {
  #Sys.getenv('BRAPI_SESSION')
  brapi$session
}

brapi_parse <- function(req) {
  text <- httr::content(req, as = "text")
  if (identical(text, "")) stop("No output to parse", call. = FALSE)
  jsonlite::fromJSON(text, simplifyVector = FALSE)
}


brapi_check <- function(req) {
  if (req$status_code == 404) stop(paste0("BRAPI call not available!\n\nDetails:\n",
                                          req$url))
  if (req$status_code == 200) return(invisible())

  message <- brapi_parse(req)$message
  stop("HTTP failure: ", req$status_code, "\n", message, call. = FALSE)
}


brapi_GET <- function(resource) {
  stopifnot(can_internet())
  url = get_brapi()
  auth <- brapi_session()
  if(auth != ""){
    path = paste0(url, resource, "session_token=", auth)
  } else {
    path = paste0(url, resource)
  }

  req <- httr::GET(path)
  brapi_check(req)

  req
}

#' Authenticate against a brapi compatible database
#'
#' Caches a session token and informs of success or failure.
#'
#' @param user characters
#' @param password characters
#' @author Reinhard Simon
#' @import httr
#' @family brapi_con
#' @export
brapi_auth <- function(user, password){
  stopifnot(can_internet())
  #W TODO display error when not authenticated
  url = paste0(get_brapi(), "token?username=", user, "&password=", password, "&grant_type=password")
  x = httr::GET(url)
  status  = httr::content(x)$session_token
  if(status == "") stop("Authentication failed. Check your user name and password!") else {
    brapi$user <<- user
    brapi$pwd <<- password
    brapi$session <<- status
    message("Authenticated!")
  }
  #Sys.setenv(BRAPI_SESSION = status)

}

