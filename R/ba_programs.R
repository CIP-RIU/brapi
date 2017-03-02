#' ba_programs
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param con brapi connection object
#' @param page integer requested page number, default = 0 (1st page)
#' @param rclass string; default: tibble
#' @param pageSize items per page (default = 100)
#' @param programName string; default: any
#' @param abbreviation string; default: any
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_programs.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ListPrograms.md}{github}
#' @family brapicore
#' @export
ba_programs <- function(con = NULL, programName = "any", abbreviation = "any",
                     page = 0, pageSize = 10000, rclass = "tibble") {
    ba_check(con, FALSE, "programs")
    stopifnot(is.character(programName))
    stopifnot(is.character(abbreviation))
    check_paging(pageSize, page)
    check_rclass(rclass)

    brp <- get_brapi(con)

    pprograms <- paste0(brp, "programs/?")

    pprogramName <- ifelse(programName != "any",
                           paste0("programName=", programName, "&"), "")
    pabbreviation <- ifelse(abbreviation != "any",
                            paste0("abbreviation=", abbreviation, "&"), "")

    ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
    ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
    if (pageSize == 10000){
      ppage <- ""
      ppageSize <- ""
    }

    pprograms <- paste0(pprograms, pprogramName, pabbreviation, ppageSize, ppage)

    try({
        res <- brapiGET(pprograms, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")

        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "ba_programs")
        return(out)
    })
}
