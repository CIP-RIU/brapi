
#' germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param germplasmDbId integer
#' @param rclass character, default: list; alternative: vector
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @import tidyjson
#' @import dplyr
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-markerprofiles}
#' @family brapi_call
#' @family genotyping
#' @family attributes
#' @export
germplasm_markerprofiles <- function(germplasmDbId = 0, rclass = "tibble"){
  brapi::check(FALSE)
  germplasm_markerprofiles = paste0(get_brapi(), "germplasm/", germplasmDbId,
                              "/markerprofiles/")

  tryCatch({
    res <- brapiGET(germplasm_markerprofiles)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res){
      markerProfiles <- NULL
      res %>% as.character %>%
        enter_object("result") %>%
        spread_values(germplasmDbId = jnumber("germplasmDbId")) %>%
        enter_object("markerProfiles") %>%
        gather_array %>%
        append_values_number("markerProfiles") %>%
        dplyr::select(germplasmDbId, markerProfiles)
    }

    if(rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    if(rclass == "vector") out = jsonlite::fromJSON(res, simplifyVector = FALSE)$result$markerProfiles %>% unlist
    if(rclass == "data.frame") out  <- ms2tbl(res)
    if(rclass == "tibble")     out  <- ms2tbl(res) %>% tibble::as_tibble()

    out
  }, error = function(e){
    NULL
  })
}
