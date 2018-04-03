#' ba_markerprofiles_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; default ''
#' @param studyDbId character; default ''
#' @param sampleDbId character; default: ''
#' @param extractDbId character; default: ''
#' @param methodDbId string; default: unknown
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
                                     methodDbId = "all",
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
  nurl <- nchar(pmarkerprofiles)
  if (nurl <= 2000) {
    ba_message(msg = "Using GET")
    out <- try({
      res <- brapiGET(url = pmarkerprofiles, con = con)
      res <- httr::content(x = res, as = "text", encoding = "UTF-8")
      dat2tbl(res = res, rclass = rclass)
    })
  }
  if (nurl > 2000) {
    ba_message(msg = "Using POST")
    x1 <- as.list(germplasmDbId)
    names(x1)[1:length(germplasmDbId)] <- "germplasm"
    x2 <- NULL
    if (extractDbId != "") {
      x2 <- as.list(extractDbId)
      names(x2)[1:length(extractDbId)] <- "extract"
    }
    body <- list(studyDbId = studyDbId,
                 sample = sampleDbId,
                 method = methodDbId,
                 page = page,
                 pageSize = pageSize)
    body <- c(x1, x2, body)
    out <- try({
      pmarkerprofiles <- paste0(brp, "markerprofiles-search/")
      res <- brapiPOST(url = pmarkerprofiles, body, con)
      res <- httr::content(x = res, as = "text", encoding = "UTF-8")
      dat2tbl(res = res, rclass = rclass)
    })
  }
  class(out) <- c(class(out), "ba_markerprofiles_search")
  show_metadata(con, res)
  return(out)
}
