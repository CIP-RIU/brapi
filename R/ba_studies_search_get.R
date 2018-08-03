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
#' @param active  logical; search studies by active status; default: "any",
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
### to be put in front of @import #' @example inst/examples/ex-ba_studies_search_get.R
ba_studies_search_get <- function(con = NULL,
                                  studyDbId = "",
                                  trialDbId = "",
                                  programDbId = "",
                                  commonCropName = "",
                                  locationDbId = "",
                                  seasonDbId = "",
                                  studyType = "",
                                  germplasmDbIds = "",
                                  observationVariableDbIds = "",
                                  active = "any",
                                  sortBy = "",
                                  sortOrder = "",
                                  pageSize = 1000,
                                  page = 0,
                                  rclass = "tibble") {
  # .Deprecated("ba_studies_search")
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search-get")
  stopifnot(is.character(studyDbId))
  stopifnot(is.character(trialDbId))
  stopifnot(is.character(programDbId))
  stopifnot(is.character(commonCropName))
  stopifnot(is.character(locationDbId))
  stopifnot(is.character(seasonDbId))
  stopifnot(is.character(studyType))
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.logical(active) || active == "any")
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pstudies_search <- paste0(brp, "studies-search?")
  pstudyDbId <- ifelse(studyDbId == "", "",
                       paste0("studyDbId=", studyDbId, "&"))
  ptrialDbId <- ifelse(trialDbId == "", "",
                       paste0("trialDbId=", trialDbId, "&"))
  pprogramDbId <- ifelse(programDbId == "", "",
                         paste0("programDbId=", programDbId, "&"))
  pcommonCropName <- ifelse(commonCropName == "", "",
                            paste0("commonCropName=", commonCropName, "&"))
  plocationDbId <- ifelse(locationDbId == "", "",
                          paste0("locationDbId=", locationDbId, "&"))
  pseasonDbId <- ifelse(seasonDbId == "", "",
                        paste0("seasonDbId=", seasonDbId, "&"))
  pstudyType <- ifelse(studyType == "", "",
                       paste0("studyType=", gsub(" ", "%20", studyType), "&"))
  pgermplasmDbIds <- ifelse(all(germplasmDbIds == ""),
                            "",
                            paste0("germplasmDbIds=",
                                   sub(pattern = ",$",
                                       replacement = "",
                                       x = paste0(germplasmDbIds,
                                                  sep = ",",
                                                  collapse = "")),
                                   "&"))
  pobservationVariableDbIds <- ifelse(all(observationVariableDbIds == ""),
                                      "",
                                      paste0("observationVariableDbIds=",
                                             sub(pattern = ",$",
                                                 replacement = "",
                                                 x = paste0(observationVariableDbIds,
                                                            sep = ",",
                                                            collapse = "")),
                                             "&"))
  pactive <- ifelse(active != "any", paste0("active=", tolower(active), "&"), "")
  psortBy <- ifelse(sortBy == "", "", paste0("sortBy=", sortBy, "&"))
  psortOrder <- ifelse(sortOrder == "", "",
                       paste0("sortOrder=", sortOrder, "&"))
  ppageSize <- ifelse(is.numeric(pageSize),
                      paste0("pageSize=", pageSize, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(pstudies_search,
                            pstudyDbId,
                            ptrialDbId,
                            pprogramDbId,
                            pcommonCropName,
                            plocationDbId,
                            pseasonDbId,
                            pstudyType,
                            pgermplasmDbIds,
                            pobservationVariableDbIds,
                            pactive,
                            psortBy,
                            psortOrder,
                            ppageSize,
                            ppage))
  nurl <- nchar(callurl)
  out <- NULL
  if (nurl <= 2000) {
    message("Using GET")
    out <- try({
      res <- brapiGET(url = callurl, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
      out <- NULL
      if (rclass %in% c("list", "json")) {
        out <- dat2tbl(res = res2, rclass = rclass)
      }
      if (rclass %in% c("data.frame", "tibble")) {
        out <- std2tbl(res = res2, rclass = rclass)
      }
      out
    })
  }
  if (nurl > 2000) {
    message("URL too long. Use ba_studies_search_post.")
  }
  if (!is.null(out)) {
    class(out) <- c(class(out), "ba_studies_search_get")
  } else {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  }
  show_metadata(res)
  return(out)
}
