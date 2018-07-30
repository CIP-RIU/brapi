#' ba_studies_search_post
#'
#' Search for study details on a brapi server via a POST method
#'
#' @param con list, brapi connection object
#' @param studyDbIds character, search for study details of specified studies,
#'                   supplied as a comma separated string of internal study
#'                   database identifiers (e.g. "1,5,19"); default: ""
#' @param trialDbIds character, search for studies and  details of specified
#'                   trials, supplied as a comma separated string of internal
#'                   trial database identifiers (e.g. "15,12,19"); default: ""
#' @param programDbIds character, search for studies and details of specified
#'                     programs, supplied as a comma separated string of
#'                     internal program database identifiers (e.g. "15,12,19");
#'                     default: ""
#' @param locationDbIds character, search for studies and detaisl of specified
#'                      locations, supplied as a comma separated string of
#'                      internal location database identifiers (e.g. "13,23,45");
#'                      default:""
#' @param seasonDbId  character, search for studies by an internal season
#'                    database identifier; default: ""
#' @param studyType character; search for studies and details based on a study
#'                  type e.g. "Nursery", "Trial" or "Genotype"; default: ""
#' @param studyNames character, search for studies by study names, supplies as a
#'                   comma separated string of study names (e.g. ); default: ""
#' @param studyLocations character; search for studies by study locations,
#'                       supplied as a comma separated string of study locations
#'                       (e.g. ); default: ""
#' @param programNames character; search for studies by program names, supplied
#'                    as a comma separated string of program names (e.g. );
#'                    default: ""
#' @param commonCropName character, search for studies by a common crop name;
#'                       default: ""
#' @param germplasmDbIds  character; search for studies where specified
#'                        germplasms, supplied as a comma separated string of
#'                        internal gerplasm database identifiers (e.g. "1,12,
#'                        281"), have been used/tested; default: ""
#' @param observationVariableDbIds  character; search for studies where specified
#'                                  observation variables, supplied as a comma
#'                                  separated string of internal observation
#'                                  variable database identifiers (e.g. "15,100"
#'                                  ), have been measured; default: ""
#' @param active  logical; search studies by active status; default: "",
#'                other possible values TRUE/FALSE
#' @param sortBy character; name of the field to sort by; default: ""
#' @param sortOrder character; sort order direction; default: "", possible values
#'                  "asc"/"desc"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the studies and
#'         details fulfilling the search criteria.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
#' @family studies
#' @family phenotyping
#' @import tibble
#' @export
### to be put in front of @import #' @example inst/examples/ex-ba_studies_search_post.R
ba_studies_search_post <- function(con = NULL,
                                   studyDbIds = "",
                                   trialDbIds = "",
                                   programDbIds = "",
                                   locationDbIds = "",
                                   seasonDbId = "",
                                   studyType = "",
                                   studyNames = "",
                                   studyLocations = "",
                                   programNames = "",
                                   commonCropName = "",
                                   germplasmDbIds = "",
                                   observationVariableDbIds = "",
                                   active = "",
                                   sortBy = "",
                                   sortOrder = "",
                                   page = 0,
                                   pageSize = 1000,
                                   rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search")
  brp <- get_brapi(con = con)
  stopifnot(is.character(studyDbIds))
  stopifnot(is.character(trialDbIds))
  stopifnot(is.character(programDbIds))
  stopifnot(is.character(seasonDbId))
  stopifnot(is.character(studyType))
  stopifnot(is.character(studyNames))
  stopifnot(is.character(studyLocations))
  stopifnot(is.character(programNames))
  stopifnot(is.character(commonCropName))
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(active))
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)

  out <- NULL

  body <- list(
    studyDbIds = studyDbIds,
    trialDbIds = trialDbIds,
    programDbIds = programDbIds,
    locationDbIds = locationDbIds,
    seasonDbId = seasonDbId,
    studyType = studyType,
    studyNames = studyNames,
    studyLocations = studyLocations,
    programNames = programNames,
    commonCropName = commonCropName,
    germplasmDbIds = germplasmDbIds,
    observationVariableDbIds = observationVariableDbIds,
    active = active,
    sortBy = sortBy,
    sortOrder = sortOrder,
    page = page,
    pageSize = pageSize
  )

  for (i in length(body)) {
    if (length(body[i]) == 0) body[i] <- NULL
  }
  #print(str(body))

  out <- try({
    pstudies_search <- paste0(brp, "studies-search")
    print(pstudies_search)
    res <- brapiPOST(url = pstudies_search, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- std2tbl(res2, rclass)
    }
    out
  })
  if (is.null(out)) {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  } else {
    class(out) <- c(class(out), "ba_studies_search")
  }
  show_metadata(res)
  return(out)
}
