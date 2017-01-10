#' brapi_variables_datatypes
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass string; default: tibble
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family core
#' @family access
#' @export
brapi_variables_datatypes <- function(con = NULL, rclass = "tibble") {
  brapi::check(FALSE, "variables/datatypes")
  brp <- get_brapi()
  variables_datatypes_list = paste0(brp, "variables/datatypes/")

  try({
    res <- brapiGET(variables_datatypes_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      colnames(out) = "variables_datatypes"
    }
    class(out) = c(class(out), "brapi_variables_datatypes")
    out
  })
}
