#' brapi_variables_ontologies
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @family observation_variables
#' @family core
#' @family brapi_call
#' @export
brapi_variables_ontologies <- function(con = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "ontologies")
  brp <- get_brapi()
  variables_ontologies = paste0(brp, "ontologies/?")

  ppage =  paste0("page=", page, "")
  ppageSize =  paste0("pageSize=", pageSize, "&")
  variables_ontologies = paste0(variables_ontologies, ppageSize, ppage)


  try({
    res <- brapiGET(variables_ontologies)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)
    class(out) = c(class(out), "brapi_variables_ontologies")
    out
  })
}
