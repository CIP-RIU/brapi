#' ba_germplasm_details
#'
#' Gets germplasm details given an id.
#'
#' @param con brapi connection object
#' @param rclass character; tibble
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @import dplyr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmDetailsByGermplasmDbId.md}{github}
#' @return list
#' @example inst/examples/ex-ba_germplasm_details.R
#' @family germplasm
#' @family brapicore
#' @export
ba_germplasm_details <- function(con = NULL,
                                 germplasmDbId = "0",
                                 rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm/id")
  stopifnot(is.character(germplasmDbId))
  check_rclass(rclass = rclass)
  # generate the brapi call url
  germplasm <- paste0(get_brapi(brapi = con), "germplasm/", germplasmDbId, "/")
  try({
    res <- brapiGET(url = germplasm, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- gp2tbl(res)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(res) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasm_details")
    return(out)
  })
}
