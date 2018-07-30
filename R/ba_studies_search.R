#' ba_studies_search
#'
#' Search studies on a brapi server via a GET or POST method
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
#' @param progamNames character; search for studies by program names, supplied
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
                              active = "",
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
