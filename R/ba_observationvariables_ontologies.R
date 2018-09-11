#' ba_observationvariables_ontologies
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con list; brapi connection object; default = NULL
#' @param pageSize integer; defautlt 1000
#' @param page integer; default 0
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableOntologyList.md}{github}

#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables_ontologies.R
#'
#' @import tibble
#' @export
ba_observationvariables_ontologies <- function(con = NULL,
                                               pageSize = 1000,
                                               page = 0,
                                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "ontologies")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  variables_ontologies <- paste0(brp, "ontologies/?")
  ppages <- get_ppages(pageSize, page)

  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(variables_ontologies,
                            ppages$pageSize,
                            ppages$page))

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_observationvariables_ontologies")
    show_metadata(res)
    return(out)
  })
}
