#' ba_studies_table
#'
#' Retrieve observation units, including actual trait data, as table for a
#' specific study.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the observation units, including actual trait data,
#'                  are to be retrieved e.g. "1001"; \strong{REQUIRED ARGUMENT}
#'                  with default: ""
#' @param format character, the format parameter will cause the data to be
#'               dumped to a file in the specified format; default: "csv",
#'               possible other values: "tsv"/"json"
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"json"
#'
#' @details This function must have set a specific study identifier. The default
#'          is an empty string. If not changed to an study identifier present in
#'          the database this will result in an error.
#'
#' @return An object of class as defined by rclass containing the observation
#'         units, including trait data, for a requested study.
#'
#' @note Tested against: BMS, testserver, sweetpotatobase
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_Table_GET.md}{github}
#'
#' @family studies
#' @family phenotyping
#'
#' @example inst/examples/ex-ba_studies_table.R
#'
#' @import tibble
#' @import readr
#' @export
ba_studies_table <- function(con = NULL,
                             studyDbId = "",
                             format = c("csv", "tsv", "json"),
                             rclass = c("tibble", "data.frame", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/table")
  studyDbId <- match_req(studyDbId)
  format <- match.arg(format)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "studies/", studyDbId, "/table?")
  pformat <- switch(format,
                    "csv"  = "format=csv&",
                    "tsv"  = "format=tsv&",
                    "json" = "")
  callurl <- sub("[/?&]$",
                       "",
                       paste0(endpoint,
                              pformat))
  try({
    res <- brapiGET(url = callurl, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass == "json") {
        out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      if (format == "json") {
        res2 <- jsonlite::fromJSON(txt = res)$result
        out <- res2$data
        out <- tibble::as.tibble(out)
        if (length(res2$headerRow) != length(colnames(out)))
          stop('Header row length does not coincide with column count. Contact database provider.')
        colnames(out) <- res2$headerRow
      }
      if (format == "csv") {
        if (con$bms == TRUE) {
          out <- read.csv(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
          url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
          out <- readr::read_csv(file = url, progress = TRUE)
        }
      }
      if (format == "tsv") {
        if (con$bms == TRUE) {
          out <- read.delim(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
          url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
          out <- readr::read_tsv(file = url, progress = TRUE)
        }
      }
      if (rclass == "data.frame") {
        class(out) <- "data.frame"
      }
    }
  })
  class(out) <- c(class(out), "ba_studies_table")
  return(out)
}
