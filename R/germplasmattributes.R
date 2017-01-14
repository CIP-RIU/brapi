#' germplasmattributes
#'
#' germplasmattributes call.
#'
#' @param con brapi connection object
#' @param attributeCategoryDbId integer; default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @import httr
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/ListAttributesByAttributeCategoryDbId.md}
#' @family germplasmattributes
#' @family genotyping
#' @export
germplasmattributes <- function(con = NULL, attributeCategoryDbId = 0, rclass = "tibble") {
    brapi::check(con, FALSE)
    brp <- get_brapi(con)
    attributes_list <- paste0(brp, "attributes/?attributeCategoryDbId=", attributeCategoryDbId)

    try({
        res <- brapiGET(attributes_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")

        out <- dat2tbl(res, rclass)
        if (rclass %in% c("tibble", "data.frame")) {
            out$values <- sapply(out$values, paste, collapse = "; ")
        }
        class(out) <- c(class(out), "brapi_germplasmattributes")
        out
    })
}
