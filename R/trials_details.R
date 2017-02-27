#' trials_details
#'
#' lists trials_details available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param trialDbId character; default: 'any'; otherwise an identifier
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Trials/GetTrialById.md}(github)
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family trials
#' @family phenotyping
#' @export
trials_details <- function(con = NULL, trialDbId = "any", rclass = "tibble") {
    brapi::check(con, FALSE, "trials/id")
    brp <- get_brapi(con)
    ptrials <- paste0(brp, "trials/", trialDbId)

    try({
        res <- brapiGET(ptrials, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("list", "json"))
            out <- dat2tbl(res, rclass)
        if (rclass %in% c("data.frame", "tibble"))
            out <- trl2tbl(res, rclass)
        class(out) <- c(class(out), "brapi_trials_details")
        return(out)
    })
}
