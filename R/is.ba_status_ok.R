# from: Maikel Verouden

is.ba_status_ok <- function(resp) {
    # if (resp$status_code == 401) {
    #     # Status Unauthorized
    #     httr::stop_for_status(resp, task = "connect due to invalid/expired token,
    #                           use brapi_auth to obtain/update your token")
    # } else {
    #     # Status other than unauthorized
    #     if (resp$status_code != 200) {
    #         if (resp$status_code == 404 | resp$status_code == 501) {
    #             # Status Unauthorized
    #             httr::stop_for_status(resp, task = "connect due to url/BrAPI call
    #                                   not implemented")
    #         } else {
    #             # Status other than Unauthorized and OK
    #             httr::stop_for_status(resp)
    #         }
    #     } else {
    #         return(TRUE)
    #     }
    # }
    # return(FALSE)

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
