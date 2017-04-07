#' ba_studies_studytypes
#'
#' lists studies_studytypes available on a brapi server
#'
#' @param con list, brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudyTypes.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_studytypes.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_studytypes <- function(con = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
    ba_check(con, FALSE, "studyTypes")
    check_paging(pageSize, page)
    check_rclass(rclass)
    
    brp <- get_brapi(con)
    pstudyTypes <- paste0(brp, "studyTypes/?")
    
    page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
    pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
    
    pstudyTypes <- paste0(pstudyTypes, pageSize, page)
    try({
        res <- brapiGET(pstudyTypes, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "ba_studies_studytypes")
        return(out)
    })
}
