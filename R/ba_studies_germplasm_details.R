#' ba_studies_germplasm_details
#'
#' Gets germplasm details for a specific study available on a brapi server.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the germplasm details are to be retrieved e.g. "1001";
#'                  \strong{REQUIRED ARGUMENT} with default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the germplasm
#'         details for a requested study.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_Germplasm_GET.md}{github}
#' @family studies
#' @family germplasm
#' @family brapicore
#' @example inst/examples/ex-ba_studies_germplasm_details.R
#' @import tibble
#' @export
ba_studies_germplasm_details <- function(con = NULL,
                                         studyDbId = "",
                                         pageSize = 1000,
                                         page = 0,
                                         rclass = c("tibble", "data.frame",
                                                    "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/germplasm")
  check_req(studyDbId)
  check_character(studyDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("studies/", studyDbId, "/germplasm")
  callurl <- get_endpoint(brp,
                          pageSize = pageSize,
                          page = page
                          )

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sgp2tbl(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_germplasm_details")
    show_metadata(resp)
    return(out)
  })
}
