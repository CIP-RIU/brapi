#' ba_studies_observations
#'
#'
#' @note Tested against: sweetpotatobase
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param studyDbId character;  \strong{REQUIRED
#'                  ARGUMENT} with default: ''
#' @param observationVariableDbId character; default: ''
#'
#' @details lists studies_observations available on a brapi server
#'
#' @details This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#' @return rclass as defined

#' @note Tested against: test-server, sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_Observations_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observations.R
#' @import tibble
#' @export
ba_studies_observations <- function(con = NULL,
                                    studyDbId = "",
                                    observationVariableDbId = "",
                                    page = 0,
                                    pageSize = 1000,
                                    rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/observations")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  stopifnot(is.character(observationVariableDbId))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_observations_list <- paste0(brp, "studies/", studyDbId,
                                      "/observations/?")
  observationVariableDbId <- paste0("observationVariableDbIds=",
                paste(observationVariableDbId, collapse = ","), "&")
  page <- ifelse(is.numeric(page), paste0("page=", page), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                  pageSize, "&"), "")
  studies_observations_list <- paste0(studies_observations_list,
                                observationVariableDbId, pageSize, page)
  try({
    res <- brapiGET(url = studies_observations_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list", "tibble", "data.frame")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observations")
    show_metadata(res)
    return(out)
  })
}
