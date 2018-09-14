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
                              rclass = c("tibble", "data.frame",
                                         "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "trials/id")
  check_character(trialDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "trials/", trialDbId)
  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- trld2tbl2(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_trials_details")
    show_metadata(resp)
    return(out)
  })
}
