#' ba_germplasm_details_study
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
#' @note BrAPI Version: 1.0
#' @note BrAPI Status: deprecated
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.0/Specification/Germplasm/GermplasmDetailsListByStudyDbId.md}{github}
#' @family germplasm
#' @family brapicore
#' @example inst/examples/ex-ba_germplasm_details_study.R
#' @import tibble
#' @export
ba_germplasm_details_study <- function(con = NULL,
                                       studyDbId = "",
                                       pageSize = 1000,
                                       page = 0,
                                       rclass = "tibble") {
  .Deprecated(new = "ba_studies_germplasm_details")
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/germplasm")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != '')
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch url of brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate brapi call url
  studies_germplasm_list <- paste0(brp, "studies/", studyDbId, "/germplasm?")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                  pageSize, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  # modify brapi call url to include pagenation
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(studies_germplasm_list,
                            ppageSize,
                            ppage))
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sgp2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_germplasm_details_study")
    show_metadata(res)
    return(out)
  })
}
