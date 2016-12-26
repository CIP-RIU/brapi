
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param germplasmDbId character; default ""
#' @param studyDbId character; default ""
#' @param sampleDbId character; default: ""
#' @param extractDbId character; default: ""
#' @param methodDbId string; default: unknown
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/markerprofiles}
#'
#' @return data.frame
#' @family brapi_call
#' @family genotyping
#' @export
markerprofiles <- function(germplasmDbId = "",
                             studyDbId = "",
                             sampleDbId  = "",
                             extractDbId = "",
                             methodDbId = "",
                             page = 0, pageSize = 10000,
                             rclass = "tibble"){
  brapi::check(FALSE, "markerprofiles")
  brp <- get_brapi()
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

  out <- try({
    res <- brapiGET(pmarkerprofiles)
    res <- httr::content(res, "text", encoding = "UTF-8")
    dat2tbl(res, rclass)
  })

  out
}

