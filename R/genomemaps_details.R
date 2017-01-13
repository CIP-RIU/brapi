#' genomemaps_details
#'
#' lists genomemaps_details available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param mapDbId integer; default 0
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDetails.md}
#' @return rclass as defined
#' @import tibble
#' @family genomemaps
#' @family genotyping
#' @export
genomemaps_details <- function(con = NULL, mapDbId = 1, rclass = "tibble") {
    # TODO: revision; rename: map_
    brapi::check(con, FALSE, "maps/id")
    brp <- get_brapi(con)
    maps_list = paste0(brp, "maps/", mapDbId, "/")
    
    try({
        res <- brapiGET(maps_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector") 
            rclass = "tibble"
        out = NULL
        if (rclass %in% c("json", "list")) 
            out = dat2tbl(res, rclass)
        if (rclass %in% c("data.frame", "tibble")) {
            lst <- jsonlite::fromJSON(res)
            dat <- jsonlite::toJSON(lst$result$linkageGroups)
            # message(dat)
            if (rclass == "data.frame") {
                out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)[[1]]
                
            } else {
                out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)[[1]] %>% tibble::as_tibble()
            }
            lst$result$linkageGroups <- NULL
            attr(out, "metadata") <- as.list(lst$result)
        }
        class(out) = c(class(out), "brapi_genomemaps_details")
        out
    })
}
