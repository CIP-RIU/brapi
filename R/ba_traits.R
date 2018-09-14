#' ba_traits
#'
#' Retrieve a list of traits available on a BrAPI compliant database server and
#' their associated variables.
#'
#' @param con list, brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"list"/"json"
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @return An object of class as defined by rclass containing the traits and
#'         their associated variables on the BrAPI compliant database server.
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Traits/ListAllTraits.md}{github}
#'
#' @family traits
#' @family brapicore
#'
#' @example inst/examples/ex-ba_traits.R
#'
#' @import tibble
#' @export
ba_traits <- function(con = NULL,
                      pageSize = 1000,
                      page = 0,
                      rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("traits")
  callurl <- get_endpoint(brp, pageSize = pageSize, page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass)

    if (rclass %in% c("data.frame", "tibble")) {
      if ("observationVariables" %in% colnames(out)) {
        out$observationVariables <- sapply(X = out$observationVariables,
                                           FUN = paste, collapse = "; ")
      }
    }
    class(out) <- c(class(out), "ba_traits")
    show_metadata(resp)
    return(out)
  })
}
