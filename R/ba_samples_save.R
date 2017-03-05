#' ba_samples_save
#'
#' Save sample data available on a brapi server.
#'
#' @param con brapi connection object
#' @param sampleData list of sample details.
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Samples/TakeASample.md}(github)
#' @example inst/examples/ex-ba_samples_save.R
#' @return character a unique sample ID assigned by the server

#' @import tidyjson
#' @family phenotyping
#' @export
ba_samples_save <- function(con = NULL, sampleData = list()) {
    ba_check(con, FALSE, "samples")
    stopifnot(is.list(sampleData))

    stopifnot(all(
      c("plotId", "plantId", "takenBy", "sampleDate", "sampleType", "tissueType", "notes") %in% names(sampleData)
    ))

    brp <- get_brapi(con)
    call_samples <- paste0(brp, "samples/")

    try({
        res <- brapiPUT(call_samples, sampleData, con = con)
        res <- httr::content(res)
        out <- res$result$sampleId

        if (!is.null(out))
            class(out) <- c(class(out), "ba_samples")
        return(out)
    }
    )
}
