#' ba_observationvariables_ontologies
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con list; brapi connection object; default = NULL
#' @param rclass character; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableOntologyList.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_observationvariables_ontologies.R
#' @import tibble
#' @family observationvariables
#' @family brapicore
#' @export
ba_observationvariables_ontologies <- function(con = NULL,
                                               page = 0,
                                               pageSize = 1000,
                                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "ontologies")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  variables_ontologies <- paste0(brp, "ontologies/?")
  ppage <- paste0("page=", page, "")
  ppageSize <- paste0("pageSize=", pageSize, "&")
  variables_ontologies <- paste0(variables_ontologies, ppageSize, ppage)
  try({
    res <- brapiGET(url = variables_ontologies, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    class(out) <- c(class(out), "ba_observationvariables_ontologies")
    return(out)
  })
}
