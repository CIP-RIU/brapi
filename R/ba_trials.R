#' ba_trials
#'
#' Lists trial summaries available on a brapi server
#'
#' @param con list, brapi connection object
#' @param programDbId character; program filter to only return trials associated
#'                    with given program database identifier; default: ""
#' @param locationDbId character, location filter to only return trails associated
#'                     with given location databas identifier; default: ""
#' @param active logical; filter active status; default: "any", other possible
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
                      active = "any",
                      sortBy = "",
                      sortOrder = "",
                      pageSize = 1000,
                      page = 0,
                      rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "trials")
  stopifnot(is.character(programDbId))
  stopifnot(is.character(locationDbId))
  stopifnot(is.logical(active) || active == "any")
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  if (programDbId == "") {
    ba_message('Consider specifying other parameters like "pogramDbId"!\n')
  }
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)

  ptrials <- paste0(brp, "trials?")
  pprogramDbId <- ifelse(programDbId != "",
                    paste0("programDbId=", programDbId, "&"), "")

  plocationDbId <- ifelse(locationDbId != "",
                    paste0("locationDbId=", locationDbId, "&"), "")

  pactive <- ifelse(active != "any", paste0("active=", tolower(active), "&"), "")
  psortBy <- ifelse(sortBy != "", paste0("sortBy=", sortBy, "&"), "")
  psortOrder <- ifelse(sortOrder != "", paste0("sortOrder=", sortOrder, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "", "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize),
                      paste0("pageSize=", pageSize, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  callurl <- sub("[/?&]$",
                 "",
                 paste0(ptrials,
                        pprogramDbId,
                        plocationDbId,
                        pactive,
                        psortBy,
                        psortOrder,
                        ppageSize,
                        ppage))
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- trl2tbl2(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_trials")
    show_metadata(res)
    return(out)
  })
}
