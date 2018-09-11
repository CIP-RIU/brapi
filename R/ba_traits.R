#' ba_traits
#'
#' lists brapi_traits available on a brapi server
#'
#'
#' @param con list; brapi connection object
#' @param pageSize integer; defautlt 1000
#' @param page integer; default 0
#' @param rclass character; default: tibble
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @return rclass as defined
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
                      rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  traits <- paste0(brp, "traits/?")
  ppages <- get_ppages(pageSize, page)

  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(traits,
                            ppages$pageSize,
                            ppages$page))
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)

    if (rclass %in% c("data.frame", "tibble")) {
      if ("observationVariables" %in% colnames(out)) {
        out$observationVariables <- sapply(X = out$observationVariables,
                                           FUN = paste, collapse = "; ")
      }
    }
    class(out) <- c(class(out), "ba_traits")
    show_metadata(res)
    return(out)
  })
}
