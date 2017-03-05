#' ba_studies_table_save
#'
#' saves a studies_table available on a brapi server
#'
#' @param studyDbId string; default: 1
#' @param con object; brapi connection object
#' @param study_table tibble a tibble or data.frame
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationUnitsAsTableSave.md}{github}
#' @return boolean
#' @example inst/examples/ex-ba_studies_table_save.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_table_save <- function(con = NULL, studyDbId = "1", study_table = NULL) {
    ba_check(con, FALSE, "studies/id/table")
    stopifnot(is.character(studyDbId))
    stopifnot(is.data.frame(study_table))

    brp <- get_brapi(con)
    studies_table <- paste0(brp, "studies/", studyDbId, "/table/")

    try({

      metadata <- list(
        pagination = list(
          pageSize = 0,
          currentPage = 0,
          totalCount = 0,
          totalPages = 0
        ),
        status = list(),
        datafiles = list()
      )

      result <- list(
        headerRow = colnames(study_table),
        observationVariableDbIds = colnames(study_table)[4:ncol(study_table)],
        data = sapply(study_table, as.character)
      )

      req <- list(

        metadata = metadata,
        result = result
      )

      dat <- jsonlite::toJSON(req)

      resp <- brapiPOST(studies_table, dat, con)

    return(invisible(TRUE))
    })
}
