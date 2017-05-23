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
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/ListAttributesByAttributeCategoryDbId.md}{github}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes <- function(con = NULL,
                                   attributeCategoryDbId = "0",
                                   rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.character(attributeCategoryDbId))
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(brapi = con)
  # generate the specific brapi call url
  attributes_list <- paste0(brp, "attributes/?attributeCategoryDbId=", attributeCategoryDbId)
  try({
    res <- brapiGET(url = attributes_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    if (rclass %in% c("tibble", "data.frame")) {
        out$values <- sapply(X = out$values, FUN = paste, collapse = "; ")
    }
    class(out) <- c(class(out), "ba_germplasmattributes")
    return(out)
  })
}
