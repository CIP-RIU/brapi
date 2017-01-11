# from: Maikel Verouden

is.status_ok <- function(resp){
  if (resp$status_code == 401) {
    # Status Unauthorized
    httr::stop_for_status(resp, task = "connect due to invalid/expired token, use brapi_auth to obtain/update your token")
  } else {
    # Status other than unauthorized
    if (resp$status_code != 200) {
      # Status other than Unauthorized and OK
      httr::stop_for_status(resp)
    } else {
      return(TRUE)
    }
  }
  FALSE
}
