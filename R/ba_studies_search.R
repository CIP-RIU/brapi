#' ba_studies_search_get
#'
#' Search for study details on a brapi server via a GET method.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, search for study details by an internal study
#'                  database identifier; default: ""
#' @param trialDbId character, search for studies by an internal trial database
#'                  identifier; default: ""
#' @param programDbId character, search studies by an internal program database
#'                    identifier; default: ""
#' @param commonCropName character, search for studies by a common crop name;
#'                       default: ""
#' @param locationDbId character, search for studies by an internal location
#'                     database identifier; default: ""
#' @param seasonDbId  character, search for studies by an internal season
#'                    database identifier; default: ""
#' @param studyType character; search for studies based on a study type e.g.
#'                  "Nursery", "Trial" or "Genotype"; default: ""
#' @param germplasmDbIds character vector; search for studies where specified
#'                       germplasms, supplied as a comma separated character
#'                       vector of internal gerplasm database identifiers e.g.
#'                       c("CML123","CWL123"), have been used/tested; default:
#'                       ""
#' @param observationVariableDbIds character vector; search for studies where
#'                                 specified observation variables, supplied as
#'                                 a comma separated character vector of
#'                                 internal observation variable database
#'                                 identifiers e.g. c("CO-PH-123:,"Var-123"),
#'                                 have been measured; default: ""
#' @param active  logical; search studies by active status; default: "TRUE",
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
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @import tibble
#' @export
### to be put in front of @import #' @example inst/examples/ex-ba_studies_search.R
ba_studies_search <- function(con = NULL,
                              studyDbId = "",
                              trialDbId = "",
                              programDbId = "",
                              commonCropName = "",
                              locationDbId = "",
                              seasonDbId = "",
                              studyType = "",
                              germplasmDbIds = "",
                              observationVariableDbIds = "",
                              active = TRUE,
                              sortBy = "",
                              sortOrder = "",
                              pageSize = 1000,
                              page = 0,
                              rclass = c("tibble", "data.frame",
                                         "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search-get")
  ba_check(con = con, verbose = FALSE)
  check_character(studyDbId, trialDbId, programDbId, locationDbId, seasonDbId, studyType,
                  germplasmDbIds,
                  observationVariableDbIds, sortBy, sortOrder)
  stopifnot(is.logical(active))
  rclass <- match.arg(rclass)
  brp <- get_brapi(con) %>% paste0("studies-search")

  callurl <- get_endpoint(brp,
                          studyDbId = studyDbId,
                          trialDbId = trialDbId,
                          programDbId = programDbId,
                          locationDbId = locationDbId,
                          seasonDbId = seasonDbId,
                          studyType = studyType,
                          germplasmDbIds = germplasmDbIds,
                          observationVariableDbIds = observationVariableDbIds,
                          active = active,
                          sortBy = sortBy,
                          sortOrder = sortOrder,
                          page = page,
                          pageSize = pageSize)

  out <- NULL

  out <- try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- std2tbl(res = cont, rclass = rclass)
    }
    out
  })

  if (!is.null(out)) {
    class(out) <- c(class(out), "ba_studies_search_get")
  } else {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  }
  show_metadata(resp)
  return(out)
}
