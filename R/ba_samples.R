#' ba_samples
#'
#' Get sample metadata available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param sampleId character
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Samples/RetrieveSampleMetadata.md}(github)
#' @example inst/examples/ex-ba_samples.R
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family phenotyping
#' @export
ba_samples <- function(con = NULL, sampleId = "", rclass = "tibble") {
    ba_check(con, FALSE, "samples")
    stopifnot(is.character(sampleId))
    stopifnot(sampleId != "")
    check_rclass(rclass)

    brp <- get_brapi(con)
    call_samples <- paste0(brp, "samples/", sampleId)

    tryCatch({
        res <- brapiGET(call_samples, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
          out <- jsonlite::fromJSON(res, simplifyDataFrame = TRUE)$result %>% tibble::as_tibble()
          if (rclass == "data.frame") {
            out <- as.data.frame(out)
          }
          }
        if (!is.null(out))
            class(out) <- c(class(out), "ba_samples")
        return(out)
    },
    error = function(e) {
      stop(paste0(e, "\n\nMalformed sampleId."))
    }
    )
}
