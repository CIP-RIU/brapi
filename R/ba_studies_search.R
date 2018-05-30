#' ba_studies_search
#'
#' lists trials available on a brapi server
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#' @note Tested against: sweetpotatobase
#'
#'
#' @param con brapi connection object
#' @param studyType character; default: ''
#' @param programDbId character; default: ''
#' @param locationDbId  character; default: ''
#' @param seasonDbId  character; default: ''
#' @param germplasmDbIds  character; default: ''
#' @param observationVariableDbIds  character; default: ''
#' @param active  character; default: ''
#' @param sortBy  character; default: ''
#' @param sortOrder  character; default: ''
#' @param page integer; default: 1000
#' @param pageSize integer; default: 0
#' @param verb character; default: 'GET' (or 'POST')
#' @param rclass character; default: tibble
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudySummaries.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_search.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_search <- function(con = NULL,
                              studyType = "",
                              programDbId = "",
                              locationDbId = "",
                              seasonDbId = "",
                              germplasmDbIds = "",
                              observationVariableDbIds = "",
                              active = "",
                              sortBy = "",
                              sortOrder = "",
                              page = 0,
                              pageSize = 1000,
                              verb = 'GET',
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search")
  brp <- get_brapi(con = con)
  stopifnot(is.character(studyType))
  stopifnot(is.character(programDbId))
  stopifnot(is.character(locationDbId))
  stopifnot(is.character(seasonDbId))
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(active))
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  pstudies_search <- paste0(brp, "studies-search/?")
  pstudyType <- ifelse(studyType == "", "",
                       paste0("studyType=", studyType, "&"))
  pprogramDbId <- ifelse(programDbId == "", "",
                         paste0("programDbId=", programDbId, "&"))
  plocationDbId <- ifelse(locationDbId == "", "",
                          paste0("locationDbId=", locationDbId, "&"))
  pseasonDbId <- ifelse(seasonDbId == "", "",
                        paste0("seasonDbId=", seasonDbId, "&"))
  pgermplasmDbIds <- ifelse(germplasmDbIds == "", "",
        paste0("germplasmDbIds=", germplasmDbIds, "&") %>%
          paste0(collapse = ""))
  pobservationVariableDbIds <- ifelse(observationVariableDbIds == "", "",
        paste0("observationVariableDbIds=",
               observationVariableDbIds, "&") %>% paste(collapse = ""))
  pactive <- ifelse(active == "", "", paste0("active=", active, "&"))
  psortBy <- ifelse(sortBy == "", "", paste0("sortBy=", sortBy, "&"))
  psortOrder <- ifelse(sortOrder == "", "",
                       paste0("sortOrder=", sortOrder, "&"))
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize),
                      paste0("pageSize=", pageSize, "&"), "")
  pstudies_search <- paste0(pstudies_search,
                            pstudyType,
                            pprogramDbId,
                            plocationDbId,
                            pseasonDbId,
                            pgermplasmDbIds,
                            pobservationVariableDbIds,
                            pactive,
                            psortBy,
                            psortOrder,
                            ppageSize,
                            ppage)
  nurl <- nchar(pstudies_search)
  out <- NULL
  if (nurl <= 2000 & verb == 'GET') {
    message("Using GET")
    out <- try({
      res <- brapiGET(url = pstudies_search, con = con)
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

  if (nurl > 2000 | verb == 'POST') {
    message("Using POST")
    x1 <- as.list(germplasmDbIds)
    names(x1)[1:length(germplasmDbIds)] <- "germplasmDbIds"
    x2 <- as.list(observationVariableDbIds)
    names(x2)[1:length(observationVariableDbIds)] <- "observationVariableDbIds"
    body <- list(studyType = studyType,
                 programDbId = programDbId,
                 locationDbId = locationDbId,
                 seasonDbId = seasonDbId,
                 active = active,
                 sortBy = sortBy,
                 sortOrder = sortOrder,
                 page = page,
                 pageSize = pageSize)
    body <- c(x1, x2, body)
    out <- try({
      pstudies_search <- paste0(brp, "studies-search/?")
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
  }
  class(out) <- c(class(out), "ba_studies_search")
  show_metadata(res)
  return(out)
}
