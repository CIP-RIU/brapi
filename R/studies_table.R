#' studies_table
#'
#' lists studies_table available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param studyDbId string; default: 1
#' @param con object; brapi connection object
#' @param format string; one of: json, csv, tsv. Defasult: json
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationUnitsAsTable.md}{github}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
studies_table <- function(con = NULL, studyDbId = 1, format = "json", rclass = "tibble") {
    brapi::check(con, FALSE, "studies/id/table")
    #
    brp <- get_brapi(con)
    studies_table <- paste0(brp, "studies/", studyDbId, "/table/?")

    if (rclass %in% c("data.frame", "tibble") & format == "json") {
        format <- "csv"
    }

    pformat <- ifelse(format %in% c("json", "csv", "tsv"), paste0("format=", format, "&"), "")
    studies_table <- paste0(studies_table, pformat)

    try({
        res <- brapiGET(studies_table, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("data.frame", "tibble")) {

            if (format == "csv") {
                url <- jsonlite::fromJSON(res)$metadata$data$url
                out <- readr::read_csv(file = url, progress = TRUE)
            }
            if (format == "tsv") {
                url <- jsonlite::fromJSON(res)$metadata$data$url
                out <- readr::read_tsv(file = url, progress = TRUE)
            }
            if (rclass == "data.frame") {
                class(out) <- "data.frame"
            }
        }

        class(out) <- c(class(out), "brapi_studies_table")
        out
    })
}
