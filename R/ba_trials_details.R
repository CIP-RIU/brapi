#' ba_trials_details
#'
#' List trial summary details for a given trial database identifier.
#'
#' @param con list, brapi connection object
#' @param trialDbId character, the internal database identifier for a trial of
#'                  which the summary details are to be retreived; \strong{REQUIRED
#'                  ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the trial summary
#'         details.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \url{https://github.com/plantbreeding/API/blob/V1.2/Specification/Trials/GetTrialById.md}(github)
#' @family trials
#' @family phenotyping
#' @example inst/examples/ex-ba_trials_details.R
#' @import tibble
#' @export
ba_trials_details <- function(con = NULL,
                              trialDbId = "",
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "trials/id")
  stopifnot(is.character(trialDbId))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  ptrials <- paste0(brp, "trials/", trialDbId)
  try({
    res <- brapiGET(url = ptrials, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- trld2tbl2(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_trials_details")
    show_metadata(res)
    return(out)
  })
}
