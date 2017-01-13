#' traits
#'
#' lists brapi_traits available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param con object; brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Traits/ListAllTraits.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @import tibble
#' @family traits
#' @family core
#' @export
traits <- function(con = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
    brapi::check(con, FALSE, "traits")
    
    brp <- get_brapi(con)
    traits = paste0(brp, "traits/?")
    
    ppage = paste0("page=", page, "")
    ppageSize = paste0("pageSize=", pageSize, "&")
    traits = paste0(traits, ppageSize, ppage)
    
    try({
        res <- brapiGET(traits, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out = dat2tbl(res, rclass)
        
        if (rclass %in% c("data.frame", "tibble")) {
            out$observationVariables = sapply(out$observationVariables, paste, collapse = "; ")
        }
        
        class(out) = c(class(out), "brapi_traits")
        out
    })
}
