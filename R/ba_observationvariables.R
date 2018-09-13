#' ba_observationvariables
#'
#' lists brapi_variables available on a brapi server
#'
#' @param con list; brapi connection object
#' @param traitClass character; default: ''
#' @param pageSize integer; default; 1000
#' @param page integer; default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableList.md}{github}
#'
#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables.R
#'
#' @import tibble
#' @export
ba_observationvariables <- function(con = NULL,
                                    traitClass = "",
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables")
  check_character(traitClass)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("variables")
  callurl <- get_endpoint(pointbase = brp,
                          traitClass = traitClass,
                          pageSize = pageSize,
                          page = page)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_observationvariables")
    show_metadata(res)
    return(out)
  })
}
