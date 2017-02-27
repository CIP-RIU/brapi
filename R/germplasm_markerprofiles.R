
#' germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId integer
#' @param rclass character, default: list; alternative: vector
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @import dplyr
#' @import tidyjson
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmMarkerprofiles.md}{github}
#' @family germplasm
#' @family genotyping
#' @export
germplasm_markerprofiles <- function(con = NULL, germplasmDbId = 3, rclass = "tibble") {
    brapi::check(con, FALSE)
    germplasm_markerprofiles <- paste0(get_brapi(con), "germplasm/", germplasmDbId, "/markerprofiles/")
    try({
        res <- brapiGET(germplasm_markerprofiles, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        ms2tbl <- function(res) {
            markerProfiles <- NULL
            res %>% as.character %>% enter_object("result") %>%
              spread_values(germplasmDbId = jnumber("germplasmDbId")) %>%
                enter_object("markerProfiles") %>% gather_array %>%
              append_values_number("markerProfiles") %>%
                dplyr::select(germplasmDbId, markerProfiles)
        }
        if (rclass %in% c("json", "list"))
            out <- dat2tbl(res, rclass)
        if (rclass == "vector")
            out <- jsonlite::fromJSON(res,
                                     simplifyVector = FALSE)$result$markerProfiles %>% unlist
        if (rclass == "data.frame")
            out <- ms2tbl(res)
        if (rclass == "tibble")
            out <- ms2tbl(res) %>% tibble::as_tibble()
        class(out) <- c(class(out), "brapi_germplasm_markerprofiles")
        return(out)
    })
}
