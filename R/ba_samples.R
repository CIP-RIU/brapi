#' ba_samples
#'
#' Get sample metadata available on a brapi server
#'
#' @note Tested against: BMS
#'
#' @param con list, brapi connection object
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"/"vector"
#' @param sampleDbId character, mandatory argument
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Samples/RetrieveSampleMetadata.md}{github}
#' @example inst/examples/ex-ba_samples.R
#' @return rclass as defined
#' @import tibble
#' @family phenotyping
#' @export
ba_samples <- function(con = NULL,
                       sampleDbId = "",
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
