#' ba_trials_details
#'
#' lists trials_details available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param trialDbId character; default: ''; otherwise an identifier
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Trials/GetTrialById.md}(github)
#' @return rclass as defined
#' @example inst/examples/ex-ba_trials_details.R
#' @import tibble
#' @family trials
#' @family phenotyping
#' @export
ba_trials_details <- function(con = NULL,
                              trialDbId = "",
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "trials/id")
  brp <- get_brapi(con = con)
  stopifnot(is.character(trialDbId))
  check_rclass(rclass = rclass)
  ptrials <- paste0(brp, "trials/", trialDbId)
  try({
    res <- brapiGET(url = ptrials, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- trld2tbl2(res = res)
    }
    class(out) <- c(class(out), "ba_trials_details")
    show_metadata(con, res)
    return(out)
  })
}
