# from: Maikel Verouden, modified: R. Simon

is.ba_status_ok <- function(resp) {

  if (resp$status_code == 200) return(TRUE)

  if (resp$status_code %in% c(400, 401)) {
    httr::stop_for_status(resp$status_code, task = "connect due to invalid/expired token,
                              use brapi_auth to obtain/update your token")
  }
  if (resp$status_code %in% c(403, 404)) {
    httr::stop_for_status(resp$status_code, task = "connect due to url/BrAPI call
                                      not implemented")
  }
  if (resp$status_code %in% c(500, 501)) {
    httr::stop_for_status(resp$status_code, task = "connect due internal server error")
  }

  return(FALSE)
}
