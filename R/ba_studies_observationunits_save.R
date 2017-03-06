#' ba_studies_observationunits_save
#'
#' Call to invoke for saving the measurements (observations) collected from field for all the observation units.
#'
#' @param con brapi connection object
#' @param studyDbId character a unique study ID
#' @param unitData data.frame or tibble observation unit data
#' @param observationLevel character plot (default) or plant
#' @param transactionDbId character string
#' @param commit logical TRUE (default)
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/SaveOrUpdateObservationUnits.md}(github)
#' @example inst/examples/ex-ba_studies_observationunits_save.R
#' @return character a unique sample ID assigned by the server

#' @import tidyjson
#' @family phenotyping
#' @export
ba_studies_observationunits_save <- function(
  con = NULL,
  studyDbId = "",
  unitData = NULL,
  observationLevel = "plot",
  transactionDbId = "1234",
  commit = TRUE
  ) {
    ba_check(con, FALSE, "samples")
    stopifnot(is.character(studyDbId))
    stopifnot(is.data.frame(unitData))
    stopifnot(nrow(unitData) > 0)
    stopifnot(all(!is.null(unitData)))
    stopifnot(all(!is.na(unitData)))
    stopifnot(is.character(observationLevel))
    stopifnot(is.character(transactionDbId))
    stopifnot(is.logical(commit))

    stopifnot(all(
      c( "observationUnitDbId", "observationDbId", "observationVariableId",
        "observationVariableName", "collector", "observationTimeStamp", "value") %in%
        colnames(unitData)
    ))

    # convert table to list structure and insert additional parameters
    ouids <- unique(unitData$observationUnitDbId)
    n <- length(ouids)

    obs <- list()

    for(i in 1:n) {

      recs <- unitData[unitData$observationUnitDbId == ouids[i], -c(1)]
      m <- nrow(recs)

      obs[[i]] <- list(
        observationUnitDbId = ouids[i],
        observations = list()
      )

      for(j in 1:m) {
        obs[[i]]$observations[[j]] <- as.list(recs[j, ])
      }


    }


    dat <- list(
      metadata = list(
        pagination = list(
          pageSize = 0,
          currentPage = 0,
          totalCount = 0,
          totalPages =0
        ),
        status = list(),
        datafiles = list()
      ),
      result = list(
        transactionDbId = transactionDbId,
        commit = tolower(as.character(commit)),
        data = obs
      )
    )


    brp <- get_brapi(con)
    call_samples <- paste0(brp, "studies/", studyDbId,
                           "/observationunits?observationLevel=",
                           observationLevel
                           )

    try({
        brapiPOST(call_samples, dat, con = con)
        return(TRUE)
    }
    )
}
