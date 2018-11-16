#' ba_studies_search_post
#'
#' Search for study details on a brapi server via a POST method.
#'
#' @param con list, brapi connection object
#' @param studyDbIds character vector, search for study details of specified
#'                   studies, supplied as a comma separated character vector of
#'                   internal study database identifiers e.g. c("35", "345");
#'                   default: ""
#' @param trialDbIds character vector, search for studies and details of
#'                   specified trials, supplied as a comma separated character
#'                   vector of internal trial database identifiers e.g.
#'                   c("7", "8"); default: ""
#' @param programDbIds character vector, search for studies and details of
#'                     specified programs, supplied as a comma separated
#'                     character vector of internal program database identifiers
#'                     e.g. c("27", "58"); default: ""
#' @param locationDbIds character vector, search for studies and details of
#'                      specified locations, supplied as a comma separated
#'                      character vector of internal location database
#'                      identifiers e.g. c("23", "33"); default:""
#' @param seasonDbId character vector, search for studies and details by
#'                   specified seasons, supplied as a comma separated character
#'                   vector of internal season database identifiers e.g.
#'                   c("237", "238"); default: ""
#' @param studyType character; search for studies and details based on a study
#'                  type e.g. "Nursery", or "Yield Trial"; default: ""
#' @param studyNames character vector, search for studies by study names,
#'                   supplied as a comma separated character vector of study
#'                   names e.g. c("Study A", "Study B"); default: ""
#' @param studyLocations character vector; search for studies by study
#'                       locations, supplied as a comma separated character
#'                       vector of study locations e.g. c("Kenya", "Zimbabwe");
#'                       default: ""
#' @param programNames character vector; search for studies by program names,
#'                     supplied as a comma separated character vector of program
#'                     names e.g. c("Test Program", "Program2");
#'                    default: ""
#' @param commonCropName character, search for studies by a common crop name
#'                       e.g. "wheat"; default: ""
#' @param germplasmDbIds character vector; search for studies where specified
#'                       germplasms, supplied as a comma separated character
#'                       vector of internal gerplasm database identifiers e.g.
#'                       c("CML123", "CWL123"), have been used/tested; default:
#'                       ""
#' @param observationVariableDbIds character vector; search for studies where
#'                                 specified observation variables, supplied as
#'                                 a comma separated character vector of
#'                                 internal observation variable database
#'                                 identifiers e.g. c("CO-PH-123", "Var-123"),
#'                                 have been measured; default: ""
#' @param active logical; search studies by active status (by default both
#'               active and inactive studies are shown); default: NA, other
#'               possible values TRUE (show active)/FALSE (show inactive)
#' @param sortBy character; name of the field to sort by e.g. "studyDbId";
#'               default: ""
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
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_search_post.R
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
                                   active = NA,
                                   sortBy = "",
                                   sortOrder = "",
                                   pageSize = 1000,
                                   page = 0,
                                   rclass = c("tibble", "data.frame",
                                              "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(studyDbIds, trialDbIds, programDbIds, locationDbIds, seasonDbId, studyType,
                  studyNames, studyLocations, programNames, commonCropName, germplasmDbIds,
                  observationVariableDbIds, sortBy, sortOrder)
  stopifnot(is.logical(active))
  rclass <- match.arg(rclass)
  callurl <- get_brapi(con) %>% paste0("studies-search")

  body <- get_body(studyDbIds = studyDbIds,
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
                   pageSize = pageSize)


  out <- try({
    resp <- brapiPOST(url = callurl, body = body, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- std2tbl(cont, rclass)
    }
    out
  })
  if (is.null(out)) {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  } else {
    class(out) <- c(class(out), "ba_studies_search")
  }
  show_metadata(resp)
  return(out)
}
