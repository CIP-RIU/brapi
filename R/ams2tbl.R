ams2tbl <- function(res, format, rclass, pb = NULL){

    res <- httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    markerprofileDbId = NULL
    alleleCall = NULL
    if(format == "json") {
      out = dat2tbl(res, rclass)
      if(rclass %in% c("data.frame", "tibble")) {
        colnames(out) =
          c("markerprofileDbId", "markerDbId", "alleleCall")
        out = tidyr::spread(out, markerprofileDbId, alleleCall)
        colnames(out)[1] = "markerprofileDbId"

      }
    }
    if(format == "csv"){
      url = jsonlite::fromJSON(res)$metadata$data$url
      out = readr::read_csv(file = url, progress = TRUE)
    }
    if(format == "tsv"){
      url = jsonlite::fromJSON(res)$metadata$data$url
      out = readr::read_tsv(file = url, progress = TRUE)
    }
    class(out) = c(class(out), "brapi_allelematrix")
    out
}
