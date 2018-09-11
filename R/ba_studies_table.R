#' ba_studies_table
#'
#' lists studies_table available on a brapi server
#'
#' @param con list; brapi connection object
#' @param studyDbId character; \strong{REQUIRED ARGUMENT} with default: ''
#' @param format character; one of: json, csv, tsv. Default: csv
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#'
#' @details This function must have set a specific study identifier. The default is an empty
#' string. If not changed to an study identifier present in the database this will
#' result in an error.

#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, BMS
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
#' @importFrom utils read.csv read.delim
#' @export
ba_studies_table <- function(con = NULL,
                             studyDbId = "",
                             format = "csv",
                             rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/table")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  stopifnot(format %in% c("json", "tsv", "csv"))
  check_rclass(rclass =  rclass)
  brp <- get_brapi(con = con)

  studies_table <- paste0(brp, "studies/", studyDbId, "/table?")

  pformat <- ifelse(format %in% c("json", "csv", "tsv"),
                    paste0("format=", format, "&"), "")
  call_url <- sub("[/?&]$",
                       "",
                       paste0(studies_table,
                              pformat))

  try({
    res <- brapiGET(url = call_url, con = con)
  })
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      if (format == "json") {
        res2 <- jsonlite::fromJSON(txt = res)$result
        out <- res2$data
        out <- tibble::as.tibble(out)
        if(length(res2$headerRow) != length(colnames(out)))
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
    class(out) <- c(class(out), "ba_studies_table")
    return(out)

}
