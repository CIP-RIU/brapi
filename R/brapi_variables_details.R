#' brapi_variables_details
#'
#' lists brapi_variables_details available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param con object; brapi connection object
#' @param observationVariableDbId string; default 'CO_334:0100622'; from test server.
#'
#' @author Reinhard Simon
#' @return rclass as defined
#' @import tibble
#' @family variables
#' @family phenotyping
#'
#' @export
brapi_variables_details <- function(con = NULL, observationVariableDbId  = "CO_334:0100622",
                            rclass = "tibble") {
  brapi::check(FALSE, "variables/id")

  brp <- get_brapi()
  brapi_variables_details = paste0(brp, "variables/", observationVariableDbId)

  try({
    res <- brapiGET(brapi_variables_details)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (!rclass %in% c("json", "list", "tibble", "data.frame")) {
      rclass = "json"
    }
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out = sov2tbl(res, rclass, TRUE)
    }
    class(out) = c(class(out), "brapi_variables_details")
    out
  })
}
