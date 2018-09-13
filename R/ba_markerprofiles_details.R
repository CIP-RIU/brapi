#' ba_markerprofiles_details
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerprofileDbId character; default 0
#' @param expandHomozygotes logical; default false
#' @param unknownString chaaracter; default: ''
#' @param sepPhased character; default: ''
#' @param sepUnphased character; default: ''
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @return rclass as requested
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/MarkerProfiles/MarkerProfiles_MarkerProfileDbId_GET.md}{github}
#'
#' @family markerprofiles
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markerprofiles_details.R
#'
#' @import httr
#' @import progress
#' @export
ba_markerprofiles_details <- function(con = NULL,
                                      markerprofileDbId = "",
                                      expandHomozygotes = FALSE,
                                      unknownString = "",
                                      sepPhased = "",
                                      sepUnphased = "",
                                      page = 0,
                                      pageSize = 10000,
                                      rclass = c("tibble", "data.frame",
                                                  "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(markerprofileDbId, unknownString, sepPhased, sepUnphased)
  stopifnot(is.logical(expandHomozygotes))
  check_req(markerprofileDbId = markerprofileDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("markerprofiles/", markerprofileDbId)
  callurl <- get_endpoint(brp,
                          expandHomozygotes = expandHomozygotes,
                          unknownString = unknownString,
                          sepPhased = sepPhased,
                          sepUnphased = sepUnphased,
                          pageSize = pageSize,
                          page = page
  )

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("data.frame", "tibble")) {
      out <- jsonlite::fromJSON(txt = res2, simplifyDataFrame = TRUE,
                                flatten = TRUE)
      meta <- out$metadata
      out <- out$result$data
      attr(out, "metadata") <- meta
      if ("uniqueDisplayName" %in% names(out))
        out$uniqueDisplayName <- sapply(X = out$uniqueDisplayName, FUN = paste, collapse = "; ")
      if ("extractDbId" %in% names(out))
        out$extractDbId <- sapply(X = out$extractDbId, FUN = paste, collapse = "; ")
      if ("markerprofileDbId" %in% names(out))
        out$markerprofileDbId <- sapply(X = out$markerprofileDbId, FUN = paste, collapse = "; ")
      if ("analysisMethods" %in% names(out))
        out$analysisMethods <- sapply(X = out$analysisMethods,
                                    FUN = paste, collapse = "; ")
    } else {
      out <- dat2tbl(res = res2 , rclass = rclass)
    }

    class(out) <- c(class(out), "ba_markerprofiles_details")
    show_metadata(res)
    return(out)
  })
}
