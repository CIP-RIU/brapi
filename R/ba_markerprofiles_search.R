#' ba_markerprofiles_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmDbId character; default ''
#' @param studyDbId character; default ''
#' @param sampleDbId character; default: ''
#' @param extractDbId character; default: ''
#' @param methodDbId character; default: ''
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @return rclass as requested
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/MarkerProfiles/MarkerProfiles_GET.md}{github}
#'
#' @family markerprofiles
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markerprofiles_search.R
#'
#' @import httr
#' @import progress
#' @export
ba_markerprofiles_search <- function(con = NULL,
                                     germplasmDbId = "",
                                     studyDbId = "",
                                     sampleDbId = "",
                                     extractDbId = "",
                                     methodDbId = "",
                                     page = 0,
                                     pageSize = 10000,
                                     rclass = c("tibble", "data.frame",
                                                "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId, studyDbId, sampleDbId, extractDbId,
                  methodDbId )
  rclass <- match.arg(rclass)
  brp <- get_brapi(con = con) %>% paste0("markerprofiles")
  callurl <- get_endpoint(brp,
                          germplasmDbId = germplasmDbId,
                          studyDbId = studyDbId,
                          sampleDbId = sampleDbId,
                          extractDbId = extractDbId,
                          methodDbId = methodDbId,
                          pageSize = pageSize,
                          page = page
  )

  out <- NULL

  out <- try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    dat2tbl(res = res2, rclass = rclass)
  })

  class(out) <- c(class(out), "ba_markerprofiles_search")
  show_metadata(res)
  return(out)
}
