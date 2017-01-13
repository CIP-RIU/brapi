#' programs
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param con brapi connection object
#' @param page integer requested page number, default = 0 (1st page)
#' @param rclass string; default: tibble
#' @param pageSize items per page (default = 100)
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ListPrograms.md}{github}
#' @family brapi_core
#' @export
programs <- function(con = NULL, page = 0, pageSize = 100, rclass = "tibble") {
    brapi::check(con, FALSE, "programs")
    brp <- get_brapi(con)
    if (page == 0 & pageSize == 100) {
        programs_list <- paste0(brp, "programs")
    } else if (is.numeric(page) & is.numeric(pageSize)) {
        programs_list <- paste0(brp, "programs/?page=", page, "&pageSize=", pageSize)
    }
    
    
    try({
        res <- brapiGET(programs_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "brapi_programs")
        out
    })
}
