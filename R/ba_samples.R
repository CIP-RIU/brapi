#' ba_samples
#'
#' Get sample metadata available on a brapi server
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param sampleId character
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Samples/RetrieveSampleMetadata.md}{github}
#' @example inst/examples/ex-ba_samples.R
#' @return rclass as defined
#' @import tibble
#' @family phenotyping
#' @export
ba_samples <- function(con = NULL,
                       sampleId = "",
                       rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "samples")
  stopifnot(is.character(sampleId))
  stopifnot(sampleId != "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(brapi = con)
  call_samples <- paste0(brp, "samples/", sampleId)
  tryCatch({
    res <- brapiGET(url = call_samples, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- jsonlite::fromJSON(txt = res, simplifyDataFrame = TRUE)$result %>%
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
    stop(paste0(e, "\n\nMalformed sampleId."))
  })
}
