#' ba_traits_details
#'
#' lists brapi_traits_details available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param traitDbId character; default ''
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Traits/TraitDetails.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_traits_details.R
#' @import tibble
#' @family traits
#' @family brapicore
#' @export
ba_traits_details <- function(con = NULL,
                              traitDbId = "",
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  stopifnot(is.character(traitDbId))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  traits <- paste0(brp, "traits/", traitDbId)
  try({
    res <- brapiGET(url = traits, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      out$observationVariables <- sapply(X = out$observationVariables, FUN = paste, collapse = "; ")
    }
    class(out) <- c(class(out), "ba_traits_details")
    show_metadata(con, res)
    return(out)
  })
}
