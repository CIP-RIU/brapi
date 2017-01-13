#' germplasm_details_study
#'
#' lists studies_germplasm available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param studyDbId character; default: 123
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmDetailsListByStudyDbId.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family germplasm
#' @family brapicore
#' @export
germplasm_details_study <- function(con = NULL, studyDbId = 123, page = 0, pageSize = 1000, rclass = "tibble") {
    # TODO revise name: to group into germplasm
    brapi::check(con, FALSE, "studies/id/germplasm")
    brp <- get_brapi(con)
    studies_germplasm_list = paste0(brp, "studies/", studyDbId, "/germplasm/?")

    page = ifelse(is.numeric(page), paste0("page=", page), "")
    pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

    studies_germplasm_list = paste0(studies_germplasm_list, pageSize, page)

    try({
        res <- brapiGET(studies_germplasm_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out = NULL
        if (rclass %in% c("json", "list")) {
            out = dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out = sgp2tbl(res, rclass)
        }
        class(out) = c(class(out), "brapi_germplasm_details_study")
        out
    })
}
