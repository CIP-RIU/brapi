#' ba_germplasm_progeny
#'
#' Gets germplasm progenies given an id.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; \strong{REQUIRED ARGUMENT} with default ''
#' @param rclass character; default: tibble
#'
#' @return character; default: tibble
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/Germplasm_Progeny_GET.md}{github}
#'
#' @family germplasm
#' @family brapicore
#'
#' @example inst/examples/ex-ba_germplasm_progeny.R
#'
#' @import dplyr
#' @export
ba_germplasm_progeny <- function(con = NULL,
                                 germplasmDbId = "",
                                 rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm/id/progeny")
  check_character(germplasmDbId)
  check_req(germplasmDbId)
  rclass <- match_req(rclass)

  callurl <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/progeny")

  try({
    res <- brapiGET(url = callurl, con = con)
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
