#' ba_observationvariables
#'
#' lists brapi_variables available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param traitClass character; default ''
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableList.md}{github}
#' @family observationvariables
#' @family brapicore
#' @example inst/examples/ex-ba_observationvariables.R
#' @import tibble
#' @export
ba_observationvariables <- function(con = NULL,
                                    traitClass = "",
                                    page = 0,
                                    pageSize = 1000,
                                    rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables")
  stopifnot(is.character(traitClass))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  brapi_variables <- paste0(brp, "variables/?")
  ptraitClass <- ifelse(traitClass != '',    paste0("traitClass=", traitClass, "&"), '')
  ppage <- paste0("page=", page, "")
  ppageSize <- paste0("pageSize=", pageSize, "&")
  brapi_variables <- paste0(brapi_variables, ptraitClass, ppageSize, ppage)

  # modify brapi call url to include pagenation
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(brapi_variables))

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
