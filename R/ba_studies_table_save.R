#' ba_studies_table_save
#'
#' saves a studies_table available on a brapi server
#'
#' @param studyDbId character; default: 1
#' @param con list; brapi connection object
#' @param study_table tibble a tibble or data.frame
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationUnitsAsTableSave.md}{github}
#' @return boolean
#' @example inst/examples/ex-ba_studies_table_save.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_table_save <- function(con = NULL,
                                  studyDbId = "1",
                                  study_table = NULL) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/table")
  stopifnot(is.character(studyDbId))
  stopifnot(is.data.frame(study_table))
  brp <- get_brapi(brapi = con)
  studies_table <- paste0(brp, "studies/", studyDbId, "/table/")
  try({
    metadata <- list(pagination = list(pageSize = 0, currentPage = 0, totalCount = 0, totalPages = 0),
                     status = list(),
                     datafiles = list())
    result <- list(headerRow = colnames(study_table),
                   observationVariableDbIds = colnames(study_table)[4:ncol(study_table)],
                   data = sapply(X = study_table, FUN = as.character))
    req <- list(metadata = metadata, result = result)
    dat <- jsonlite::toJSON(x = req, pretty = TRUE)
    ba_message(msg = dat)
    brapiPOST(url = studies_table, body = dat, con = con)
    return(invisible(TRUE))
  })
}
