#' brapi_traits_details
#'
#' lists brapi_traits_details available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param con object; brapi connection object
#' @param traitDbId alphanumeric; default 1
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/brapi_traits_details/Listbrapi_traits_details.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
brapi_traits_details <- function(con = NULL, traitDbId = 1, rclass = "tibble") {
  brapi::check(FALSE, "traits")

  brp <- get_brapi()
  traits = paste0(brp, "traits/", traitDbId)

  try({
    res <- brapiGET(traits)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)

    if (rclass %in% c("data.frame", "tibble")) {
      out$observationVariables = sapply(out$observationVariables, paste, collapse = "; ")
    }

    class(out) = c(class(out), "brapi_traits_details")
    out
  })
}
