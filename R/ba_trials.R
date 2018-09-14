#' ba_trials
#'
#' Lists trial summaries available on a brapi server
#'
#' @param con list, brapi connection object
#' @param programDbId character; program filter to only return trials associated
#'                    with given program database identifier; default: ""
#' @param locationDbId character, location filter to only return trails associated
#'                     with given location databas identifier; default: ""
#' @param active logical; filter active status; default: TRUE, other possible
#'               values TRUE/FALSE
#' @param sortBy character; name of the field to sort by; default: ""
#' @param sortOrder character; sort order direction; default: "", possible values
#'                  "asc"/"desc"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing tiral summaries.
#'
#' @note Tested against: BMS, sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Trials/ListTrialSummaries.md}{github}
#' @family trials
#' @family phenotyping
#' @example inst/examples/ex-ba_trials.R
#' @import tibble
#' @export
ba_trials <- function(con = NULL,
                      programDbId = "",
                      locationDbId = "",
                      active = TRUE,
                      sortBy = "",
                      sortOrder = "",
                      pageSize = 1000,
                      page = 0,
                      rclass = c("tibble", "data.frame",
                                 "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(programDbId, locationDbId, sortBy, sortOrder)
  stopifnot(is.logical(active))
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("trials")
  callurl <- get_endpoint(brp,
                          programDbId = programDbId,
                          locationDbId = locationDbId,
                          active = active,
                          sortBy = sortBy,
                          sortOrder = sortOrder,
                          pageSize = pageSize,
                          page = page
                          )

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- trl2tbl2(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_trials")
    show_metadata(resp)
    return(out)
  })
}
