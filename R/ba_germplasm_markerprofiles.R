#' ba_germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId integer
#' @param rclass character, default: list; alternative: vector
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @example inst/examples/ex-ba_germplasm_markerprofiles.R
#' @import httr
#' @import dplyr
#' @import tidyjson
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmMarkerprofiles.md}{github}
#' @family germplasm
#' @family genotyping
#' @export
ba_germplasm_markerprofiles <- function(con = NULL,
                                        germplasmDbId = "3",
                                        rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.character(germplasmDbId))
  check_rclass(rclass = rclass)
  # generate brapi call url
  germplasm_markerprofiles <- paste0(get_brapi(con = con), "germplasm/", germplasmDbId, "/markerprofiles/")
  try({
    res <- brapiGET(url = germplasm_markerprofiles, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res) {
      markerProfiles <- NULL
      res <- res %>%
             as.character %>%
             tidyjson::enter_object("result") %>%
             tidyjson::spread_values(germplasmDbId = tidyjson::jnumber("germplasmDbId")) %>%
             tidyjson::enter_object("markerProfiles") %>%
             tidyjson::gather_array %>%
             tidyjson::append_values_number("markerProfiles") %>%
             dplyr::select(germplasmDbId, markerProfiles)
      return(res)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass == "vector") {
      out <- jsonlite::fromJSON(txt = res, simplifyVector = FALSE)$result$markerProfiles %>% unlist
    }
    if (rclass == "data.frame") {
      out <- ms2tbl(res = res)
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = res) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasm_markerprofiles")
    return(out)
  })
}
