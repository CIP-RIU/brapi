#' ba_germplasm_markerprofiles
#'
#' Retrieve the internal markerprofile database identifiers for a given internal
#' germplasm database identifier
#'
#' @param con list, brapi connection object
#' @param germplasmDbId character, the internal database identifier for a
#'                      germplasm of which the internal markerprofile database
#'                      identifiers are to be retrieved e.g. "9932";
#'                      \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the internal
#'         markerprofile database identifiers.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/Germplasm_Markerprofiles_GET.md}{github}
#'
#' @family germplasm
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasm_markerprofiles.R
#'
#' @import httr
#' @import dplyr
#' @export
ba_germplasm_markerprofiles <- function(con = NULL,
                                        germplasmDbId = "",
                                        rclass = c("tibble", "data.frame",
                                                   "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId)
  check_req(germplasmDbId)
  rclass <- match.arg(rclass)

  callurl <- paste0(get_brapi(con = con), "germplasm/", germplasmDbId, "/markerprofiles")

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
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
      if (length(df$markerprofileDbIds) == 0) {
        df$markerprofileDbIds <- ""
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
      out <- dat2tbl(res = cont, rclass = rclass)
    }

    if (rclass == "data.frame") {
      out <- ms2tbl(res = cont)
    }
    if (rclass == "vector") {
      out <- ms2tbl(res = cont)[, 2]
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = cont) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasm_markerprofiles")
    show_metadata(resp)
    return(out)
  })
}
