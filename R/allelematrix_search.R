
#' allelematrix search
#'
#' Gets markers in matrix format. If the format parameter is set to either csv or tsv the returned object
#' is always a tibble object. If the format parameter is 'json' (default) the rclass parameter can be used
#' to as in other functions.
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

  pallelematrix_search = paste0(brp, "allelematrix-search/?")
  pmarkerprofileDbId = paste0("markerprofileDbId=", markerprofileDbId, "&") %>% paste(collapse = "")
  pmarkerDbId = paste0("markerDbId=", markerDbId, "&") %>% paste(collapse = "")

  pexpandHomozygotes = ifelse(expandHomozygotes != "", paste0("expandHomozygotes=", tolower(expandHomozygotes), "&"), "")
  psepPhased = ifelse(sepPhased != "", paste0("sepPhased=", sepPhased, "&"), "")
  psepUnphased = ifelse(sepUnphased != "", paste0("sepUnphased=", sepUnphased, "&"), "")

  ppage = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  rclass = ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")
  pformat = ifelse(format %in% c("json", "csv", "tsv"), paste0("format=", format, "&"), "")

  pallelematrix_search = paste0(pallelematrix_search, pmarkerprofileDbId, pmarkerDbId,
                               pexpandHomozygotes, psepPhased, psepUnphased, pformat,
                                  ppageSize, ppage)


  nurl = nchar(pallelematrix_search)
  #method = ifelse(nurl<=2000, "GET", "POST")
  #pb <- progress::progress_bar$new(total = 100)
  message(method)

  if(method == "GET"){
    out <- try({
      res <- brapiGET(pallelematrix_search)
      ams2tbl(res, format, rclass)
    })

  }
  if(method == "POST"){
    x1 = as.list(markerprofileDbId)
    names(x1)[1:length(markerprofileDbId)] = "markerprofileDbId"
    x2 = as.list(markerDbId)
    names(x2)[1:length(markerDbId)] = "markerDbId"
    body = list(expandHomozygotes  = expandHomozygotes %>% tolower(),
                unknownString = unknownString,
                sepPhased = sepPhased,
                sepUnphased = sepUnphased,
                format = format,
                page = page,
                pageSize = pageSize)
    body = c(x1, x2, body)
    #print(body)
    #message(names(body))
    out <- try({
      pallelematrix_search = paste0(brp, "allelematrix-search/?")
      #message(pallelematrix_search)
      # message(body)
      res <- brapiPOST(pallelematrix_search, body )
      #print(res$status_code)
      ams2tbl(res, format, rclass)
    })
  }

  out
}

