#' ba_studies_search
#'
#' Search studies on a brapi server via a GET or POST method.
#'
#' @param con list, brapi connection object
#' @param studyDbIds character vector, search for study details of specified
#'                   studies, supplied as a comma separated character vector of
#'                   internal study database identifiers e.g. c("35", "345");
#'                   default: ""
#' @param trialDbIds character vector, search for studies and  details of
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
#' @param active logical; search studies by active status; default: "any",
#'               other possible values TRUE/FALSE
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
#' @note BrAPI Version: 1.0, 1.1, 1.2, (1.3)
#' @note BrAPI Status: active
#' @note In version 1.3 only one call will replace the studies_search_get and
#'       studies_search_post. Since its parameters are most similar to the _post
#'       version, it is recommended to use the _post or this version.
#' @note This call must have set a specific identifier. The default is an empty
#'       string. If not changed to an identifier present in the database this
#'       will result in an error.
#'
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_search.R
#' @import tibble
#' @export
ba_studies_search <- function(con = NULL,
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
                              active = "any",
                              sortBy = "",
                              sortOrder = "",
                              page = 0,
                              pageSize = 1000,
                              rclass = "tibble") {
  ba_studies_search_post(con = con,
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
                         pageSize = pageSize,
                         rclass = rclass)
}
