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
#' @details When specifying the format argument, be aware that format = "csv" or
#'          "tsv" can only be combined with rclass = "tibble" or "data.frame".
#'          Using format = "json" allows for specifying the rclass = "json",
#'          "tibble, or "data.frame".
#'
#' @details Choosing format = "json" could give unexpected results, because
#'          pagenation  (default: pageSize = 1000 and page = 0) is not
#'          implemented correctly on all databases and additionally the table
#'          for the specific study could have more than 1000 rows.
#'
#' @return An object of class as defined by rclass containing the observation
#'         units, including trait data, for a requested study.
#'
#' @note Tested against: BMS, test-server, sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
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
                             format = c("csv", "tsv", "json"),
                             rclass = c("tibble", "data.frame", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/table")
  check_req(studyDbId = studyDbId)
  format <- match.arg(format)
  rclass <- match.arg(rclass)

  if (format == "csv" && rclass == "json") {
    stop('Please read the details section in the function documentation\nabout specifying the "format" and "rclass" arguments.')
  }
  if (format == "tsv" && rclass == "json") {
    stop('Please read the details section in the function documentation\nabout specifying the "format" and "rclass" arguments.')
  }

  brp <- get_brapi(con = con) %>% paste0("studies/", studyDbId, "/table")
  format <- ifelse(format == "json", "", format)
  callurl <- get_endpoint(brp,
                          format = format)
  try({
    resp <- brapiGET(url = callurl, con = con)
    res <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass == "json") {
        out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      if (format == "") {# means format = "json", see line 62
        resList <- jsonlite::fromJSON(txt = res)$result
        out <- as.data.frame(x = resList$data, stringsAsFactors = FALSE)
        if ((length(resList$headerRow) +
             length(resList$observationVariableNames)) != ncol(out)) {
          stop('Header row length does not coincide with column count. Contact database provider.')
        }
        colnames(out) <- c(resList$headerRow, resList$observationVariableNames)
      }
      if (format == "csv") {
        if (con$bms == TRUE) {
          out <- read.csv(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
          url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
          out <- readr::read_csv(file = url, progress = TRUE)
          out <- as.data.frame(x = out, stringsAsFactors = FALSE)
        }
      }
      if (format == "tsv") {
        if (con$bms == TRUE) {
          out <- read.delim(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
          url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
          out <- readr::read_tsv(file = url, progress = TRUE)
          out <- as.data.frame(x = out, stringsAsFactors = FALSE)
        }
      }
      if (rclass == "tibble") {
        out <- tibble::as.tibble(out)
      }
    }
  })
  class(out) <- c(class(out), "ba_studies_table")
  return(out)
}
