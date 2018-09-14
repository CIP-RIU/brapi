#' ba_samples
#'
#' Get sample metadata available on a brapi server
#'
#' @note Tested against: BMS
#'
#' @param con list, brapi connection object
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#' @param sampleDbId character, mandatory argument
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Samples/Samples_GET.md}{github}
#'
#' @family phenotyping
#'
#' @example inst/examples/ex-ba_samples.R
#'
#' @import tibble
#' @export
ba_samples <- function(con = NULL,
                       sampleDbId = "",
                       rclass = c("tibble", "data.frame",
                                  "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "samples")
  check_req(sampleDbId)
  check_character(sampleDbId)
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con) %>% paste0("samples/", sampleDbId)

  tryCatch({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    out <- dat2tbl(cont, rclass, result_level = "result")
     if (!is.null(out)) {
      class(out) <- c(class(out), "ba_samples")
    }
    return(out)
  }, error = function(e) {
    stop(paste0(e, "\n\nMalformed sampleDbId."))
  })
}
