#' ba_germplasm_progeny
#'
#' Gets germplasm progenies given an id.
#'
#' @param con brapi connection object
#' @param rclass character; tibble
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @import dplyr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/Germplasm_GermplasmDbId_Progeny_GET.yaml}{github}
#' @return list
#' @example inst/examples/ex-ba_germplasm_progeny.R
#' @family germplasm
#' @family brapicore
#' @export
ba_germplasm_progeny <- function(con = NULL,
                                 germplasmDbId = "",
                                 rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm/id/progeny")
  stopifnot(is.character(germplasmDbId))
  check_rclass(rclass = rclass)
  # generate the brapi call url
  germplasm <- paste0(get_brapi(con = con), "germplasm/", germplasmDbId, "/progeny")
  try({
    res <- brapiGET(url = germplasm, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- dat2tbl(res = res2, rclass = rclass, result_level = "progeny")
    }
    if (rclass == "tibble") {
      out <- dat2tbl(res = res2, rclass = rclass, result_level = "progeny") %>% tibble::as_tibble(validate = FALSE)
    }
    class(out) <- c(class(out), "ba_germplasm_progeny")

    show_metadata(res)
    return(out)
  })
}
