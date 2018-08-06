#' ba_studies_layout
#'
#' Retrieve the plot layout of a specific study available on a brapi server.
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the plot layout is to be retrieved e.g. "1001";
#'                  \strong{REQUIRED ARGUMENT} with default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the plot layout
#'         for a requested study.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_Layout_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_layout.R
#' @import tibble
#' @export
ba_studies_layout <- function(con = NULL,
                              studyDbId = "",
                              pageSize = 1000,
                              page = 0,
                              rclass = "tibble") {
  ba_check(con = con, verbose =  FALSE, brapi_calls = "studies/id/layout")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_layout_list <- paste0(brp, "studies/", studyDbId, "/layout?")
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
                 x = paste0(studies_layout_list,
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
      out <- lyt2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_layout")
    show_metadata(res)
    return(out)
  })
}
