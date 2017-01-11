
#' markerprofiles_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; default ""
#' @param studyDbId character; default ""
#' @param sampleDbId character; default: ""
#' @param extractDbId character; default: ""
#' @param methodDbId string; default: unknown
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
# @param method character; default: GET else POST
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/MarkerProfiles/MarkerProfileSearch.md}
#'
#' @return data.frame
#' @family markerprofiles
#' @family genotyping
#' @export
markerprofiles_search <- function(con = NULL, germplasmDbId = "",
                             studyDbId = "",
                             sampleDbId  = "",
                             extractDbId = "",
                             methodDbId = "all",
                             page = 0, pageSize = 10000,
                             #method = "GET",
                             rclass = "tibble"){
  brapi::check(con, FALSE, "markerprofiles")
  brp <- get_brapi(con)
  pmarkerprofiles = paste0(brp, "markerprofiles/?")

  #germplasmDbId = ifelse(is.numeric(germplasmDbId), paste0("germplasm=", germplasmDbId, "&"), "")
  pgermplasmDbId = paste0("germplasm=", germplasmDbId, "&") %>% paste(collapse = "")
  pextractDbId = paste0("extract=", extractDbId, "&") %>% paste(collapse = "")

  pstudyDbId = ifelse(studyDbId != "", paste0("studyDbId=", studyDbId, "&"), "")
  psampleDbId = ifelse(sampleDbId != "", paste0("sample=", sampleDbId, "&"), "")
  #extractDbId = ifelse(extractDbId != "", paste0("extract=", extractDbId, "&"), "")
  pmethodDbId = ifelse(methodDbId != "", paste0("method=", methodDbId, "&"), "")

  ppage = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  rclass = ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")

  pmarkerprofiles = paste0(pmarkerprofiles, pgermplasmDbId, pstudyDbId, psampleDbId, pextractDbId,
                          pmethodDbId, ppageSize, ppage)

  out <- NULL

  nurl = nchar(pmarkerprofiles)

  if(nurl <= 2000){
    message_brapi("Using GET")
    out <- try({
      res <- brapiGET(pmarkerprofiles, con = con)
      res <- httr::content(res, "text", encoding = "UTF-8")
      dat2tbl(res, rclass)
    })

  }
  if(nurl > 2000){
    message_brapi("Using POST")

    x1 = as.list(germplasmDbId)
    names(x1)[1:length(germplasmDbId)] = "germplasm"
    x2 = NULL
    if(extractDbId != ""){
      x2 = as.list(extractDbId)
      names(x2)[1:length(extractDbId)] = "extract"
    }

    body = list(
                 studyDbId = studyDbId,
                 sample = sampleDbId, #ifelse(sampleDbId !="", sampleDbId, NULL),
                 method = methodDbId, #ifelse(methodDbId !="", methodDbId, NULL),
                page = page,
                pageSize = pageSize)
    body = c(x1, x2, body)

    #print(body)

    out <- try({
      pmarkerprofiles = paste0(brp, "markerprofiles-search/")
      res <- brapiPOST(pmarkerprofiles, body, con)
      res <- httr::content(res, "text", encoding = "UTF-8")
      dat2tbl(res, rclass)
    })
  }

  class(out) = c(class(out), "brapi_markerprofiles_search")
  out
}

