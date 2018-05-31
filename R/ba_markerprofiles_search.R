#' ba_markerprofiles_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; default ''
#' @param studyDbId character; default ''
#' @param sampleDbId character; default: ''
#' @param extractDbId character; default: ''
#' @param methodDbId string; default: ''
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/MarkerProfiles/MarkerProfileSearch.md}{github}
#'
#' @return data.frame
#' @example inst/examples/ex-ba_markerprofiles_search.R
#' @family markerprofiles
#' @family genotyping
#' @export
ba_markerprofiles_search <- function(con = NULL,
                                     germplasmDbId = "",
                                     studyDbId = "",
                                     sampleDbId = "",
                                     extractDbId = "",
                                     methodDbId = "",
                                     page = 0,
                                     pageSize = 10000,

                                     rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "markerprofiles")
  stopifnot(is.character(germplasmDbId))
  stopifnot(is.character(studyDbId))
  stopifnot(is.character(sampleDbId))
  stopifnot(is.character(methodDbId))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pmarkerprofiles <- paste0(brp, "markerprofiles/?")
  pgermplasmDbId <- paste0("germplasm=", germplasmDbId, "&") %>%
    paste(collapse = "")
  pextractDbId <- paste0("extract=", extractDbId, "&") %>%
    paste(collapse = "")
  pstudyDbId <- ifelse(studyDbId != "", paste0("studyDbId=",
                                               studyDbId, "&"), "")
  psampleDbId <- ifelse(sampleDbId != "", paste0("sample=",
                                                 sampleDbId, "&"), "")
  pmethodDbId <- ifelse(methodDbId != "", paste0("method=",
                                                 methodDbId, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  rclass <- ifelse(rclass %in% c("tibble", "data.frame", "json", "list"),
                   rclass, "tibble")
  pmarkerprofiles <- paste0(pmarkerprofiles,
                            pgermplasmDbId,
                            pstudyDbId,
                            psampleDbId,
                            pextractDbId,
                            pmethodDbId,
                            ppageSize,
                            ppage)
  out <- NULL


  out <- try({
    res <- brapiGET(url = pmarkerprofiles, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    dat2tbl(res = res2, rclass = rclass)
  })

  class(out) <- c(class(out), "ba_markerprofiles_search")
  show_metadata(res)
  return(out)
}
