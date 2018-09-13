#' ba_germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId character, \strong{REQUIRED ARGUMENT} with default: ''
#' @param rclass default: tibble
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/Germplasm_Markerprofiles_GET.md}{github}
#'
#' @family germplasm
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasm_markerprofiles.R
#' @import httr
#' @import dplyr
#' @export
ba_germplasm_markerprofiles <- function(con = NULL,
                                        germplasmDbId = "",
                                        rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId)
  check_req(germplasmDbId)
  rclass <- match.arg(rclass)

  callurl <- paste0(get_brapi(con = con), "germplasm/", germplasmDbId, "/markerprofiles")

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res) {
      lst <- tryCatch(
        jsonlite::fromJSON(txt = res)
      )

      assertthat::assert_that("result" %in% names(lst),
                    msg = "The json return object lacks a result element.")
      dat <- jsonlite::toJSON(x = lst$result)
      df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE,
                               flatten = TRUE)
      if(length(df$markerprofileDbIds) == 0) {
        df$markerprofileDbIds <- ''
      }

      res3 <- tibble::as.tibble(df)
      # assertthat::assert_that(all(c("germplasmDbId",
      #                               "markerprofileDbIds") %in%
      #                               names(df)),
      #       msg = "The json return object lacks germplasmDbId and
      #       markerprofileDbIds.")
      # # assertthat::assert_that((length(df$markerprofileDbIds) >= 1),
      # #     msg = "No markerprofileDbIdas")
      # res3 <-  as.data.frame(cbind(germplasmDbId = rep(df$germplasmDbId,
      #                                         length(df$markerprofileDbIds)),
      #                       markerProfiles = df$markerprofileDbIds),
      #                       stringsAsFactors = FALSE)
      return(res3)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }

    if (rclass == "data.frame") {
      out <- ms2tbl(res = res2)
    }
    if (rclass == "vector") {
      out <- ms2tbl(res = res2)[, 2]
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = res2) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasm_markerprofiles")
    show_metadata(res)
    return(out)
  })
}
