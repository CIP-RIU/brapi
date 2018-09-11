#' ba_traits_details
#'
#' lists brapi_traits_details available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param traitDbId character; \strong{REQUIRED ARGUMENT} with default ''
#' @param con list; brapi connection object
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, testserver
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Traits/TraitDetails.md}{github}
#' @family traits
#' @family brapicore
#'
#' @example inst/examples/ex-ba_traits_details.R
#'
#' @import tibble
#' @export
ba_traits_details <- function(con = NULL,
                              traitDbId = "",
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  stopifnot(is.character(traitDbId) | traitDbId == "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "traits/", traitDbId)
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = endpoint)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass, result_level = "result")
    if (rclass %in% c("data.frame", "tibble")) {
      out$observationVariables <- sapply(X = out$observationVariables,
                                         FUN = paste, collapse = "; ")
    }
    class(out) <- c(class(out), "ba_traits_details")
    show_metadata(res)
    return(out)
  })
}
