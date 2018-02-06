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
      lst <- tryCatch(
        jsonlite::fromJSON(txt = res)
      )

      assertthat::assert_that("result" %in% names(lst), msg = "The json return object lacks a result element.")
      dat <- jsonlite::toJSON(x = lst$result)
      df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)

      assertthat::assert_that(all(c("germplasmDbId", "markerprofileDbIds") %in% names(df)),
                              msg = "The json return object lacks germplasmDbId and markerprofileDbIds.")
      assertthat::assert_that(length(df$markerprofileDbIds) > 0,
          "No markerprofileDbIdas")
      res <-  as.data.frame(cbind(germplasmDbId = rep(df$germplasmDbId, length(df$markerprofileDbIds)),
                            markerProfiles = df$markerprofileDbIds), stringsAsFactors = FALSE)
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
