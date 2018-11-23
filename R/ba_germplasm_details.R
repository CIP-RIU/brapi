#' ba_germplasm_details
#'
#' Gets germplasm details given an internal database identifier.
#'
#' @param con brapi connection object
#' @param germplasmDbId character, the internal database identifier for a
#'                      germplasm of which the germplasm details are to be
#'                      retrieved e.g. "382" ; \strong{REQUIRED ARGUMENT} with
#'                      default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the germplasm
#'         details.
#'
#' @note Tested against: sweetpotatobase, test-server, genesys
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/Germplasm_GET.md}{github}
#'
#' @family germplasm
#' @family brapicore
#'
#' @example inst/examples/ex-ba_germplasm_details.R
#'
#' @import dplyr
#' @export
ba_germplasm_details <- function(con = NULL,
                                 germplasmDbId = "",
                                 rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm/id")
  check_character(germplasmDbId)
  check_req(germplasmDbId)
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- gp2tbl(cont)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(cont) %>% tibble::as_tibble(validate = FALSE)
    }
    class(out) <- c(class(out), "ba_germplasm_details")

    show_metadata(resp)
    return(out)
  })
}
