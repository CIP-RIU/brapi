#' ba_genomemaps_details
#'
#' lists genomemaps_details available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param mapDbId character; default 1
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDetails.md}
#' @return rclass as defined
#' @example inst/examples/ex-genomemaps_details.R
#' @import tibble
#' @family genomemaps
#' @family genotyping
#' @export
ba_genomemaps_details <- function(con = NULL, mapDbId = "1", rclass = "tibble") {

    ba_check(con, FALSE, "maps/id")
    stopifnot(is.character(mapDbId))
    check_rclass(rclass)
    brp <- get_brapi(con)
    maps_list <- paste0(brp, "maps/", mapDbId, "/")
    try({
        res <- brapiGET(maps_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector")
            rclass <- "tibble"
        out <- NULL
        if (rclass %in% c("json", "list"))
            out <- dat2tbl(res, rclass)
        if (rclass %in% c("data.frame", "tibble")) {
            lst <- jsonlite::fromJSON(res)
            dat <- jsonlite::toJSON(lst$result$linkageGroups)
            if (rclass == "data.frame") {
                out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
                out <- out[[1]]
            } else {
                out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE) #%>%
                if (class(out) == "list"){
                  out <- out[[1]]
                }
                  out <- tibble::as_tibble(out)
            }
            if (!is.null(lst$result$linkageGroups)) {
              lst$result$linkageGroups <- NULL
            }

            attr(out, "metadata") <- as.list(lst$result)
        }
        class(out) <- c(class(out), "ba_genomemaps_details")
        return(out)
    })
}
