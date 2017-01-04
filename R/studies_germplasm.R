#' studies_germplasm
#'
#' lists studies_germplasm available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param studyDbId character; default: 123
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/studies_germplasm/Liststudies_germplasm.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
studies_germplasm <- function(studyDbId = 123, page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "studies/id/germplasm")
  brp <- get_brapi()
  studies_germplasm_list = paste0(brp, "studies/", studyDbId ,"/germplasm/?")

  page = ifelse(is.numeric(page), paste0("page=", page), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  studies_germplasm_list = paste0(studies_germplasm_list, pageSize, page )

  try({
    res <- brapiGET(studies_germplasm_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out = sgp2tbl(res, rclass)
    }
    class(out) = c(class(out), "brapi_studies_germplasm")
    out
  })
}
