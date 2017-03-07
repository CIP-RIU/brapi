#' ba_phenotypes_search
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi connection object
#' @param germplasmDbIds  vector of string; default: any
#' @param observationVariableDbIds  vector of string; default: any
#' @param studyDbIds  vector of string; default: any
#' @param locationDbIds  vector of string; default: any
#' @param programDbIds  vector of string; default: any
#' @param seasonDbIds  vector of string; default: any
#' @param observationLevel  vector of string; default: any
#' @param pageSize integer default: 100
#' @param page integer default: 0
#' @param rclass string; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_phenotypes_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Phenotypes/PhenotypeSearch.md}{github}
#' @family brapicore
#' @export
ba_phenotypes_search <- function(
  con = NULL,
  germplasmDbIds = "any",
  observationVariableDbIds = "any",
  studyDbIds = "any",
  locationDbIds = "any",
  programDbIds = "any",
  seasonDbIds = "any",
  observationLevel = "any",
  pageSize = 100,
  page = 0,
  rclass = "tibble") {

  ba_check(con, FALSE, "phenotypes-search")
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(studyDbIds))
  stopifnot(is.character(locationDbIds))
  stopifnot(is.character(programDbIds))
  stopifnot(is.character(seasonDbIds))
  stopifnot(is.character(observationLevel))
  check_paging(pageSize, page)
  check_rclass(rclass)

  brp <- get_brapi(con)

  pvariables <- paste0(brp, "phenotypes-search/")

  try({
    body <- list(germplasmDbIds = germplasmDbIds,
                 observationVariableDbIds = observationVariableDbIds,
                 studyDbIds = studyDbIds,
                 locationDbIds = locationDbIds,
                 programDbIds = programDbIds,
                 seasonDbIds = seasonDbIds ,
                 observationLevel = observationLevel ,

                 pageSize = pageSize,
                 page = page
                 )
    res <- brapiPOST(pvariables, body, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")

    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- jsonlite::fromJSON(res, simplifyDataFrame = T)
      out1 <- out$result$data

      n <- nrow(out1)
      nr <- sapply(out1$observations, nrow)
      nid <- rep(out1$observationUnitDbId, times = nr)

      for (i in 1:n) {
        out1$observations[[i]] <- rbind()
        # first join tables then prepend id col

        # then merge
      }

      #out <- sov2tbl(res, rclass, TRUE)
    }
    class(out) <- c(class(out), "ba_phenotypes_search")
    return(out)
  })
}
