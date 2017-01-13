#' traits_details
#'
#' lists brapi_traits_details available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param con object; brapi connection object
#' @param traitDbId alphanumeric; default 1
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Traits/TraitDetails.md}(github)
#' @author Reinhard Simon
#' @return rclass as defined
#' @import tibble
#' @family traits
#' @family brapicore
#' @export
traits_details <- function(con = NULL, traitDbId = 1, rclass = "tibble") {
    brapi::check(con, FALSE, "traits")

    brp <- get_brapi(con)
    traits = paste0(brp, "traits/", traitDbId)

    try({
        res <- brapiGET(traits, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out = dat2tbl(res, rclass)

        if (rclass %in% c("data.frame", "tibble")) {
            out$observationVariables = sapply(out$observationVariables, paste, collapse = "; ")
        }

        class(out) = c(class(out), "brapi_traits_details")
        out
    })
}
