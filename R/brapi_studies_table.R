#' brapi_studies_table
#'
#' lists brapi_studies_table available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param studyDbId string; default: 1
#' @param con object; brapi connection object
#' @param format string; one of: json, csv, tsv. Defasult: json
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/brapi_studies_table/Listbrapi_studies_table.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
brapi_studies_table <- function(con = NULL, studyDbId = 1, format = "json", rclass = "tibble") {
  brapi::check(FALSE, "studies/id/table")
  #stopifnot(format %in% c("json", "tsv", "csv"))
  brp <- get_brapi()
  studies_table = paste0(brp, "studies/", studyDbId, "/table/?")

  if (rclass %in% c("data.frame", "tibble") & format == "json") {
    format = "csv"
  }

  pformat = ifelse(format %in% c("json", "csv", "tsv"), paste0("format=", format, "&"), "")
  studies_table = paste0(studies_table, pformat)


  try({
    res <- brapiGET(studies_table)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {

      if(format == "csv"){
        url = jsonlite::fromJSON(res)$metadata$data$url
        out = readr::read_csv(file = url, progress = TRUE)
      }
      if(format == "tsv"){
        url = jsonlite::fromJSON(res)$metadata$data$url
        out = readr::read_tsv(file = url, progress = TRUE)
      }
      if(rclass == "data.frame"){
        class(out) = "data.frame"
      }
    }

    class(out) = c(class(out), "brapi_studies_table")
    out
  })
}
