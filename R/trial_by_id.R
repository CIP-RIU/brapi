#' trial_by_id
#'
#' lists trials available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param trialDbId character; default: 'any'; otherwise an identifier
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Trials/ListTrialSummaries.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
trial_by_id <- function(trialDbId = "any", rclass = "tibble") {
  brapi::check(FALSE, "trials/id")
  brp <- get_brapi()
  ptrials = paste0(brp, "trials/", trialDbId)

  try({
    res <- brapiGET(ptrials)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if(rclass %in% c("list", "json")) out = dat2tbl(res, rclass)
    if(rclass %in% c("data.frame", "tibble")) out = trl2tbl(res, rclass)
    out
  })
}
