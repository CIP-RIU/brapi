#' ba_traits
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
#' @example inst/examples/ex-ba_traits.R
#' @import tibble
#' @family traits
#' @family brapicore
#' @export
ba_traits <- function(con = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
    ba_check(con, FALSE, "traits")
    check_paging(pageSize, page)
    check_rclass(rclass)

    brp <- get_brapi(con)
    traits <- paste0(brp, "traits/?")

    ppage <- paste0("page=", page, "")
    ppageSize <- paste0("pageSize=", pageSize, "&")
    traits <- paste0(traits, ppageSize, ppage)

    try({
        res <- brapiGET(traits, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)

        if (rclass %in% c("data.frame", "tibble")) {
          if ("observationVariables" %in% colnames(out)) {
            out$observationVariables <- sapply(out$observationVariables, paste, collapse = "; ")
          }
        }

        class(out) <- c(class(out), "ba_traits")
        return(out)
    })
}
