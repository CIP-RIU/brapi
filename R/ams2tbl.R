ams2tbl <- function(res, format, rclass){

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
      out = utils::read.csv(url, stringsAsFactors = FALSE)
      if(rclass == "tibble"){
        out = tibble::as_tibble(out)
      }
    }
    if(format == "tsv"){
      url = jsonlite::fromJSON(res)$metadata$data$url
      out = utils::read.delim(url, stringsAsFactors = FALSE)
      if(rclass == "tibble"){
        out = tibble::as_tibble(out)
      }
    }
    out
}
