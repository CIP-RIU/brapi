#' ba_samples_search
#'
#' Used to retrieve list of Samples from a Sample Tracking system based on some search criteria.
#'
#' @note Tested against: BMS
#'
#' @param con brapi connection object
#' @param sampleDbId character, default ''
#' @param observationUnitDbId character, default ''
#' @param plateDbId character, default ''
#' @param germplasmDbId character, default ''
#' @param pageSize integer,default 1000
#' @param page integer, default 0
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Samples/RetrieveSampleMetadata.md}{github}
#'
#' @family phenotyping
#'
#' @example inst/examples/ex-ba_samples.R

#' @import tibble
#' @export
ba_samples_search <- function(con = NULL,
                       sampleDbId = "",
                       observationUnitDbId = "",
                       plateDbId = "",
                       germplasmDbId = "",
                       pageSize = 1000,
                       page = 0,
                       rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "samples")
  stopifnot(is.character(sampleDbId))
  stopifnot(sampleDbId != "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  call_samples <- sub("[/?&]$",
                      "",
                      paste0(brp, "samples/", sampleDbId, "/"))
  tryCatch({
    res <- brapiGET(url = call_samples, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- jsonlite::fromJSON(txt = res, simplifyDataFrame = TRUE)$result %>%
             lapply(FUN = function(x) {x <- ifelse(is.null(x), "", x)}) %>%
             tibble::as_tibble()
      if (rclass == "data.frame") {
        out <- as.data.frame(x = out)
      }
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_samples")
    }
    return(out)
  }, error = function(e) {
    stop(paste0(e, "\n\nMalformed sampleDbId."))
  })
}
