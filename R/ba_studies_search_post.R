#' ba_studies_search_post
#'
#' Search for study details on a brapi server via a POST method.
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
                                   active = "any",
                                   sortBy = "",
                                   sortOrder = "",
                                   page = 0,
                                   pageSize = 1000,
                                   rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search")
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
  stopifnot(is.logical(active) || active == "any")
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)

  brp <- get_brapi(con = con)
  pstudies_search <- paste0(brp, "studies-search")

  body <- list(
    studyDbIds = as.array(ifelse(studyDbIds != "", studyDbIds, "")),
    trialDbIds = as.array(ifelse(trialDbIds != "", trialDbIds, "")),
    programDbIds = as.array(ifelse(programDbIds != "", programDbIds, "")),
    locationDbIds = as.array(ifelse(locationDbIds != "", locationDbIds, "")),
    seasonDbId = as.array(ifelse(seasonDbId != "", seasonDbId, "")),
    studyType = ifelse(studyType != "", studyType, ""),
    studyNames = as.array(ifelse(studyNames != "", studyNames, "")),
    studyLocations = as.array(ifelse(studyLocations != "", studyLocations, "")),
    programNames = as.array(ifelse(programNames != "", programNames, "")),
    commonCropName = ifelse(commonCropName != "", commonCropName, ""),
    germplasmDbIds = as.array(ifelse(germplasmDbIds != "", germplasmDbIds, "")),
    observationVariableDbIds = as.array(ifelse(observationVariableDbIds != "",
                                               observationVariableDbIds,
                                               "")),
    active = ifelse(active != "any", tolower(active), ""),
    sortBy = ifelse(sortBy != "", sortBy, ""),
    sortOrder = ifelse(sortOrder != "", sortOrder, ""),
    pageSize = ifelse(pageSize != "", pageSize %>% as.integer(), ""),
    page = ifelse(page != "", page %>% as.integer(), "")
  )
  for (i in length(body):1) {
    if (all(body[[i]] == "")) {
      body[[i]] <- NULL
    }
  }
  out <- NULL
  message("Using POST")
  out <- try({
    # print(pstudies_search)
    res <- brapiPOST(url = pstudies_search, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
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
