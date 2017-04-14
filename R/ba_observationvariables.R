#' ba_observationvariables
#'
#' lists brapi_variables available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @param traitClass character; default 'all'
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableList.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_observationvariables.R
#' @import tibble
#' @family observationvariables
#' @family brapicore
#'
#' @export
ba_observationvariables <- function(con = NULL, traitClass = "all", page = 0, pageSize = 1000, rclass = "tibble") {
    ba_check(con, FALSE, "variables")
    stopifnot(is.character(traitClass))
    check_paging(pageSize, page)
    check_rclass(rclass)
    
    brp <- get_brapi(con)
    brapi_variables <- paste0(brp, "variables/?")
    
    ptraitClass <- paste0("traitClass=", traitClass, "&")
    ppage <- paste0("page=", page, "")
    ppageSize <- paste0("pageSize=", pageSize, "&")
    brapi_variables <- paste0(brapi_variables, ptraitClass, ppageSize, ppage)
    
    try({
        res <- brapiGET(brapi_variables, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- sov2tbl(res, rclass, TRUE)
        }
        class(out) <- c(class(out), "ba_observationvariables")
        return(out)
    })
}
