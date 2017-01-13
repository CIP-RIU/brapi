#' germplasm_details
#'
#' Gets germplasm details given an id.
#'
#' @param con brapi connection object
#' @param rclass character; tibble
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @import tidyjson
#' @import dplyr
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmDetailsByGermplasmDbId.md}
#' @return list
#' @family germplasm
#' @family core
#' @export
germplasm_details <- function(con = NULL, germplasmDbId = 0, rclass = "tibble") {
    # TODO: revision; rename: map
    brapi::check(con, FALSE, "germplasm/id")
    germplasm = paste0(get_brapi(con), "germplasm/", germplasmDbId, "/")
    
    try({
        res <- brapiGET(germplasm, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        
        if (rclass %in% c("json", "list")) 
            out <- dat2tbl(res, rclass)
        if (rclass == "data.frame") 
            out <- gp2tbl(res)
        if (rclass == "tibble") 
            out <- gp2tbl(res) %>% tibble::as_tibble()
        
        class(out) = c(class(out), "brapi_germplasm_details")
        out
    })
}
