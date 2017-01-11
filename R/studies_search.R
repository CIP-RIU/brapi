#' studies_search
#'
#' lists trials available on a brapi server
#'
#' @param con brapi connection object
#' @param studyType string; default: any
#' @param programDbId string; default: any
#' @param locationDbId  string; default: any
#' @param seasonDbId  string; default: any
#' @param germplasmDbIds  string; default: any
#' @param observationVariableDbIds  string; default: any
#' @param active  string; default: any
#' @param sortBy  string; default: any
#' @param sortOrder  string; default: any
#' @param page integer; default: 1000
#' @param pageSize integer; default: 0
#' @param rclass string; default: tibble
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudySummaries.md}
#' @author Reinhard Simon
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
studies_search <- function(con = NULL, studyType = "any", programDbId = "any", locationDbId = "any", seasonDbId = "any",
                           germplasmDbIds = "any", observationVariableDbIds = "any",
                           active = "any", sortBy = "any", sortOrder = "any",
                           page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(con, FALSE, "studies-search")
  brp <- get_brapi(con)
  pstudies_search = paste0(brp, "studies-search/?")

  pstudyType = paste0("studyType=", studyType, "&")
  pprogramDbId = paste0("programDbId=", programDbId, "&")
  plocationDbId = paste0("locationDbId=", locationDbId, "&")
  pseasonDbId = paste0("seasonDbId=", seasonDbId, "&")
  pgermplasmDbIds = paste0("germplasmDbIds=", germplasmDbIds, "&") %>% paste0(collapse = "")
  pobservationVariableDbIds = paste0("observationVariableDbIds=", observationVariableDbIds, "&") %>% paste(collapse = "")
  pactive = paste0("active=", active, "&")
  psortBy = paste0("sortBy=", sortBy, "&")
  psortOrder = paste0("sortOrder=", sortOrder, "&")

  ppage = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  pstudies_search = paste0(pstudies_search, pstudyType, pprogramDbId, plocationDbId, pseasonDbId, pgermplasmDbIds, pobservationVariableDbIds,
                   pactive, psortBy, psortOrder, ppageSize, ppage)

  nurl = nchar(pstudies_search)
  out <- NULL
  if(nurl <= 2000){
    message("Using GET")

    out <-   try({
      res <- brapiGET(pstudies_search, con = con)
      res <- httr::content(res, "text", encoding = "UTF-8")
      out = NULL
      if(rclass %in% c("list", "json")) out = dat2tbl(res, rclass)
      if(rclass %in% c("data.frame", "tibble")) out = std2tbl(res, rclass)
      out
    })

  } else {
    message("Using POST")
    x1 = as.list(germplasmDbIds)
    names(x1)[1:length(germplasmDbIds)] = "germplasmDbIds"
    x2 = as.list(observationVariableDbIds)
    names(x2)[1:length(observationVariableDbIds)] = "observationVariableDbIds"
    body = list(studyType = studyType,
                programDbId = programDbId,
                locationDbId = locationDbId,
                seasonDbId = seasonDbId,

                active = active,
                sortBy = sortBy,
                sortOrder = sortOrder,
                page = page,
                pageSize = pageSize)
    body = c(x1, x2, body)
    out <- try({
      pstudies_search = paste0(brp, "studies-search/?")
      res <- brapiPOST(pstudies_search, body, con)
      res <- httr::content(res, "text", encoding = "UTF-8")
      out = NULL
      if(rclass %in% c("list", "json")) out = dat2tbl(res, rclass)
      if(rclass %in% c("data.frame", "tibble")) out = std2tbl(res, rclass)
      out
    })

  }
  class(out) = c(class(out), "brapi_studies_search")
  out
  out
}
