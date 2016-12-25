
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param markerprofileDbId character vector; default ""
#' @param markerDbId character vector; default ""
#' @param expandHomozygotes logical; default false
#' @param unknownString chaaracter; default: '-'
#' @param sepPhased character; default: '|'
#' @param sepUnphased character; default: '/'
#' @param format character; default: json; other: csv, tsv
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param method character; web access method. Default: GET; other: POST
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/allelematrix_search}
#'
#' @return data.frame
#' @family brapi_call
#' @family genotyping
#' @export
allelematrix_search <- function(markerprofileDbId = "",
                                markerDbId = "",
                             expandHomozygotes = FALSE,
                             unknownString  = "-",
                             sepPhased = "|",
                             sepUnphased = "/",
                             format = "json",
                             page = 0, pageSize = 10000,
                             method = "GET",
                             rclass = "tibble") {
  brapi::check(FALSE, "allelematrix-search")
  brp <- get_brapi()

  allelematrix_search = paste0(brp, "allelematrix-search/?")
  markerprofileDbId = paste0("markerprofileDbId=", markerprofileDbId, "&") %>% paste(collapse = "")
  markerDbId = paste0("markerDbId=", markerDbId, "&") %>% paste(collapse = "")

  expandHomozygotes = ifelse(expandHomozygotes != "", paste0("expandHomozygotes=", tolower(expandHomozygotes), "&"), "")
  sepPhased = ifelse(sepPhased != "", paste0("sepPhased=", sepPhased, "&"), "")
  sepUnphased = ifelse(sepUnphased != "", paste0("sepUnphased=", sepUnphased, "&"), "")

  page = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  rclass = ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")

  allelematrix_search = paste0(allelematrix_search, markerprofileDbId, markerDbId,
                               expandHomozygotes, sepPhased, sepUnphased,
                                  pageSize, page)




  if(method == "GET"){
    out <- try({
      res <- brapiGET(allelematrix_search)
      ams2tbl(res, format, rclass)
    })

  } else {
    x1 = as.list(markerprofileDbId)
    names(x1)[1:length(markerprofileDbId)] = "markerprofileDbId"
    x2 = as.list(markerDbId)
    names(x2)[1:length(markerDbId)] = "markerDbId"
    body = list(#markerprofileDbId = markerprofileDbId %>% paste(collapse = ","),
                #markerDbId = markerDbId %>% paste(collapse = ","),

                expandHomozygotes  = expandHomozygotes %>% tolower(),
                unknownString = unknownString,
                sepPhased = sepPhased,
                sepUnphased = sepUnphased,
                format = format,
                page = page,
                pageSize = pageSize)
    body = c(x1, x2, body)
    out = try({
      allelematrix_search = paste0(brp, "allelematrix-search/")
      # message(allelematrix_search)
      # message(body)
      res <- brapiPOST(allelematrix_search, body)
      ams2tbl(res, format, rclass)
    })
  }

  out
}

