#' ba_studies_search
#'
#' Search studies on a brapi server via a GET or POST method
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#' @note Tested against: sweetpotatobase
#'
#' @param con brapi connection object
#'
#' @param studyDbIds character; default: ''
#' @param trialDbIds character; default: ''
#' @param programDbIds  character; default: ''
#' @param locationDbIds  character; default: ''
#' @param seasonDbId  character; default: ''
#' @param studyType  character; default: ''
#' @param studyNames  character; default: ''
#' @param studyLocations  character; default: ''
#' @param programNames  character; default: ''
#' @param commonCropName  character; default: ''
#' @param germplasmDbIds  character; default: ''
#' @param observationVariableDbIds  character; default: ''
#' @param active  character; default: ''
#' @param sortBy  character; default: ''
#' @param sortOrder  character; default: ''
#' @param page integer; default: 1000
#' @param pageSize integer; default: 0

#' @param rclass character; default: tibble
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
# @example inst/examples/ex-ba_studies_search.R

#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2, (1.3)
#' @note BrAPI Status: active
#' @note in version 1.3 only one call will replace the studies_search_get and studies_search_post.
#' Since its parameters are most similar to the _post version, it is recommended to use the _post
#' or this version.

#' @import tibble
#' @family studies
#' @family phenotyping
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
