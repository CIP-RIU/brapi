
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param markerprofileDbId integer; default 0
#' @param markerDbId integer; default 0
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
allelematrix_search <- function(markerprofileDbId = 0,
                                markerDbId = 0,
                             expandHomozygotes = FALSE,
                             unknownString  = "-",
                             sepPhased = "|",
                             sepUnphased = "/",
                             format = "json",
                             page = 0, pageSize = 10000,
                             method = "GET",
                             rclass = "tibble") {
  brapi::check(FALSE)
  brp <- get_brapi()
  if (markerprofileDbId > 0) {
    allelematrix_search = paste0(brp, "allelematrix-search/?markerprofileDbId=",
                                    paste(markerprofileDbId, collapse = ",")
    )
  }
  if (markerDbId > 0) {
    allelematrix_search = paste0(allelematrix_search, "&markerDbId=",
                                 paste(markerDbId, collapse = ",")
    )
  }

  if (is.numeric(page) & is.numeric(pageSize)) {
    allelematrix_search = paste0(allelematrix_search, "&page=", page, "&pageSize=", pageSize)
  }

  allelematrix_search = paste0(allelematrix_search, "&expandHomozygtes=", expandHomozygotes)
  allelematrix_search = paste0(allelematrix_search, "&unknownString=", unknownString)
  allelematrix_search = paste0(allelematrix_search, "&sepPhased=", sepPhased)
  allelematrix_search = paste0(allelematrix_search, "&sepUnphased=", sepUnphased)
  allelematrix_search = paste0(allelematrix_search, "&format=", format)

  if(method == "GET"){
    out <- tryCatch({
      res <- brapiGET(allelematrix_search)
      res <- httr::content(res, "text", encoding = "UTF-8")
      out = NULL
      if(format == "json") {
        out = dat2tbl(res, rclass)
        if(rclass %in% c("data.frame", "tibble")) {
          colnames(out) =
           c("markerprofileDbId", "markerDbId", "alleleCall")
        }
      }
      if(format == "csv"){
        url = jsonlite::fromJSON(res)$metadata$data$url
        out = read.csv(url, stringsAsFactors = FALSE)
        if(rclass == "tibble"){
          out = tibble::as_tibble(out)
        }
      }
      if(format == "tsv"){
        url = jsonlite::fromJSON(res)$metadata$data$url
        out = read.delim(url, stringsAsFactors = FALSE)
        if(rclass == "tibble"){
          out = tibble::as_tibble(out)
        }
      }

      out
    }, error = function(e){
      NULL
    })

  } else {
    body = list(markerprofileDbId = markerprofileDbId %>% paste(collapse = ","),
                markerDbId = markerDbId %>% paste(collapse = ","),
                expandHomozygotes  = expandHomozygotes,
                unknownString = unknownString,
                sepPhased = sepPhased,
                sepUnphased = sepUnphased,
                format = format,
                page = page,
                pageSize = pageSize)
    out = tryCatch({
      allelematrix_search = paste0(brp, "allelematrix-search/")
      res <- brapiPOST(allelematrix_search, body)
      res <- httr::content(res, "text", encoding = "UTF-8")
      out <- NULL
      #
      # if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
      # if (rclass == "data.frame") out  <- gp2tbl(res)
      # if (rclass == "tibble")     out  <- gp2tbl(res) %>% tibble::as_tibble()
      #
      if(format == "json") {
        out = dat2tbl(res, rclass)
      }


      out
    }, error = function(e){
      NULL
    })

  }

  out
}

