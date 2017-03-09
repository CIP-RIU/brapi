#' ba_germplasmattributes
#'
#' germplasmattributes call.
#'
#' @param con brapi connection object
#' @param attributeCategoryDbId integer; default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @example inst/examples/ex-ba_germplasmattributes.R
#' @import httr
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/ListAttributesByAttributeCategoryDbId.md}{github}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes <- function(con = NULL, attributeCategoryDbId = "0", rclass = "tibble") {
    ba_check(con, FALSE)
    stopifnot(is.character(attributeCategoryDbId))
    check_rclass(rclass)

    brp <- get_brapi(con)
    attributes_list <- paste0(brp, "attributes/?attributeCategoryDbId=", attributeCategoryDbId)

    try({
        res <- brapiGET(attributes_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")

        out <- dat2tbl(res, rclass)
        if (rclass %in% c("tibble", "data.frame")) {
            out$values <- sapply(out$values, paste, collapse = "; ")
        }
        class(out) <- c(class(out), "ba_germplasmattributes")
        return(out)
    })
}
