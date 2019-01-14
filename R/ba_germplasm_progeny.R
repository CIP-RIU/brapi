#' ba_germplasm_progeny
#'
#' Retrieve the internal germplasm database identifiers for all the progeny of
#' a particular internal germplasm database identifier.
#'
#' @param con list, brapi connection object
#' @param germplasmDbId character, the internal database identifier for a
#'                      germplasm of which the internal germaplasm database
#'                      identifiers of all the progeny are to be retrieved e.g.
#'                      "9932"; \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the internal
#'         germplasm database identifiers for all the progeny.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
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
                                 rclass = c("tibble", "data.frame",
                                            "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm/id/progeny")
  check_character(germplasmDbId)
  check_req(germplasmDbId)
  rclass <- match_req(rclass)

  callurl <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/progeny")

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- dat2tbl(res = cont, rclass = rclass, result_level = "progeny")
    }
    if (rclass == "tibble") {
      out <- dat2tbl(res = cont, rclass = rclass, result_level = "progeny") %>% tibble::as_tibble(validate = FALSE)
    }
    class(out) <- c(class(out), "ba_germplasm_progeny")

    show_metadata(resp)
    return(out)
  })
}
