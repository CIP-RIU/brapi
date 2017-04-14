#' ba_traits_details
#'
#' lists brapi_traits_details available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param traitDbId character; default 1
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Traits/TraitDetails.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_traits_details.R
#' @import tibble
#' @family traits
#' @family brapicore
#' @export
ba_traits_details <- function(con = NULL, traitDbId = "1", rclass = "tibble") {
    ba_check(con, FALSE, "traits")
    stopifnot(is.character(traitDbId))
    check_rclass(rclass)
    
    brp <- get_brapi(con)
    traits <- paste0(brp, "traits/", traitDbId)
    
    try({
        res <- brapiGET(traits, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)
        
        if (rclass %in% c("data.frame", "tibble")) {
            out$observationVariables <- sapply(out$observationVariables, paste, collapse = "; ")
        }
        
        class(out) <- c(class(out), "ba_traits_details")
        return(out)
    })
}
