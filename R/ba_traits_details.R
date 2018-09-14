#' ba_traits_details
#'
#' Retrieve the details and associated variables of specific trait identifier.
#'
#' @param con list, brapi connection object
#' @param traitDbId character, the internal database identifier for a trait of
#'                  which the details and associated variables are to be retrieved
#'                  e.g. "1"; \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the details and
#'         associated variables of the requested trait identifier.
#'
#' @note Tested against: sweetpotatobase, testserver
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Traits/TraitDetails.md}{github}
#'
#' @family traits
#' @family brapicore
#'
#' @example inst/examples/ex-ba_traits_details.R
#'
#' @import tibble
#' @export
ba_traits_details <- function(con = NULL,
                              traitDbId = "",
                              rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  check_character(traitDbId)
  check_req(traitDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "traits/", traitDbId)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass, result_level = "result")
    if (rclass %in% c("data.frame", "tibble")) {
      out$observationVariables <- sapply(X = out$observationVariables,
                                         FUN = paste, collapse = "; ")
    }
    class(out) <- c(class(out), "ba_traits_details")
    show_metadata(resp)
    return(out)
  })
}
