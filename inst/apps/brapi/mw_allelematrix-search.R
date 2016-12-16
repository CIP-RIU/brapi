library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))
source(system.file("apps/brapi/utils/toTextTable.R", package = "brapi"))

allelematrix_search_data = tryCatch({
  read.csv(system.file("apps/brapi/data/markerprofiles.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

allelematrix_search_alleles_data = tryCatch({
  read.csv(system.file("apps/brapi/data/markerprofiles_alleles.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


allelematrix_search_list = function(markerprofilesDbId = "", markerDbId = "",
                                  unknownString = "-", expandHomozygotes = TRUE,
                                  sepPhased ="|", sepUnphased ="/",
                                  format = "json",
                                  page = 0, pageSize = 1000){

  #message(format)
  markerprofilesDbId <- tryCatch({safe_split(markerprofilesDbId, ",") %>% as.integer()},
                                 error = function(e){NA})
  if(!any(is.na(markerprofilesDbId))) {
    allelematrix_search_data <- allelematrix_search_data[
      allelematrix_search_data$markerProfilesDbId %in% markerprofilesDbId, ]
  }
  if(nrow(allelematrix_search_data) == 0) return(NULL)
  #if(!any(markerprofilesDbId == allelematrix_search_alleles_data$markerprofilesDbId)) return(NULL)

  markerDbId <- tryCatch({safe_split(markerDbId, ",") %>% as.integer()}, error = function(e){NA})

  if(!is.na(markerDbId) & is.integer(markerDbId) & markerDbId[1] > 0) {
    allelematrix_search_alleles_data <- allelematrix_search_alleles_data[
      allelematrix_search_alleles_data$markerDbId %in% markerDbId, ]
  }
  if(nrow(allelematrix_search_alleles_data) == 0) return(NULL)
  x <- allelematrix_search_alleles_data[allelematrix_search_alleles_data$markerprofilesDbId %in% markerprofilesDbId, c(1,2,4)]
  if(nrow(x) == 0) return(NULL)

  # paging here after filtering
  pg = paging(x, page, pageSize)
  x <- x[pg$recStart:pg$recEnd, ]

  out = list()

  if(format == "json"){
    if(!is.null(allelematrix_search_alleles_data)) {
      nn <- nrow(x)
      if(!is.null(nn)){
      #out[[i]]$data = list(nn)
      #out$data = list(nn)
      for (j in 1:nn) {
        #out[[i]]$data[[j]] <- as.character(x[j, ])
        out[[j]] <- as.character(x[j, ])
      }
      }
    }
  } else {
    x = tidyr::spread(x, markerDbId, alleleCall)
    colnames(x)[2:ncol(x)] = paste0("m", colnames(x)[2:ncol(x)])
    out = toTextTable(x, format)
    pg$pagination = list(pageSize = 0, currentPage = 0, totalPages = 0, totalCount = 0)
    attr(out, "datafiles") = list(url =
              paste0("http://127.0.0.1:2021/brapi/v1/allelematrix-search/", format, "/",
                     "?markerprofileDbId=", paste(markerprofilesDbId, collapse = ","),
                     "&markerDbId=", paste(markerDbId, collapse = ","),
                     "&unknownString", unknownString,
                     "&expandHomozygotes=", expandHomozygotes,
                     "&sepPhased=", sepPhased,
                     "&sepUnphased=", sepUnphased)
              )
  }
  attr(out, "pagination") = pg$pagination
  out
}


allelematrix_search = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(allelematrix_search_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list()
)


process_allelematrix_search <- function(req, res, err){
  prms <- names(req$params)

  markerprofilesDbId = ifelse('markerprofileDbId' %in% prms, req$params$markerprofileDbId, "")
  markerDbId = ifelse('markerDbId' %in% prms, req$params$markerDbId, "")
  unknownString = ifelse('unknownString' %in% prms, req$params$unknownString, "-")
  expandHomozygotes = ifelse('expandHomozygotes' %in% prms, req$params$expandHomozygotes, TRUE)
  sepPhased = ifelse('sepPhased' %in% prms, req$params$sepPhased, "|")
  sepUnphased = ifelse('sepUnphased' %in% prms, req$params$sepUnphased, "/")
  format = ifelse('format' %in% prms, req$params$format, "json")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 10000)

  allelematrix_search$result$data = allelematrix_search_list(
    markerprofilesDbId, markerDbId,
    unknownString, expandHomozygotes, sepPhased, sepUnphased, format,
    page, pageSize)

  allelematrix_search$metadata$pagination = attr(allelematrix_search$result$data, "pagination")
  if(!is.null(attr(allelematrix_search$result$data, "datafiles"))){
    allelematrix_search$metadata$data = list(url = attr(allelematrix_search$result$data, "datafiles")$url)
  }

  if((format %in% c("csv", "tsv")) ){
    allelematrix_search$result$data = list()
  }


  if(is.null(allelematrix_search$result$data)){
    res$set_status(404)
    allelematrix_search$metadata <- brapi_status(100, "No matching results!")
  }
  #res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(allelematrix_search)
}


process_allelematrix_search_format <- function(req, res, err){

  # TODO use allelematrix.csv? and allelematrix.tsv?
  format = ifelse(basename(req$path) %in% c("csv", "tsv"), basename(req$path), "json")
  #message(format)
  prms <- names(req$params)

  #message("1")
  markerprofilesDbId = ifelse('markerprofileDbId' %in% prms, req$params$markerprofileDbId, "")
  markerDbId = ifelse('markerDbId' %in% prms, req$params$markerDbId, "")
  unknownString = ifelse('unknownString' %in% prms, req$params$unknownString, "-")
  expandHomozygotes = ifelse('expandHomozygotes' %in% prms, req$params$expandHomozygotes, TRUE)
  sepPhased = ifelse('sepPhased' %in% prms, req$params$sepPhased, "|")
  sepUnphased = ifelse('sepUnphased' %in% prms, req$params$sepUnphased, "/")

  txt = allelematrix_search_list(
    markerprofilesDbId, markerDbId,
    unknownString, expandHomozygotes, sepPhased, sepUnphased, format = format)

  out = as.character(txt)

  if(out == '') {
    res$set_status(404)
    txt = "No matching results!"
    res$content_type("text/txt")
    res$text(txt)
  } else {
    res$content_type(paste0("text/", format))
    res$text(out)
  }
  #res$set_header("Access-Control-Allow-Methods", "GET")
}


mw_allelematrix_search <<-
  collector() %>%
  get("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    process_allelematrix_search(req, res, err)
  }) %>%
  get("/brapi/v1/allelematrix-search/csv/?", function(req, res, err){
    process_allelematrix_search_format(req, res, err)
  }) %>%
  get("/brapi/v1/allelematrix-search/tsv/?", function(req, res, err){
    process_allelematrix_search_format(req, res, err)
  }) %>%

  post("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    process_allelematrix_search(req, res, err)
  }) %>%
  post("/brapi/v1/allelematrix-search/csv/?", function(req, res, err){
    process_allelematrix_search_format(req, res, err)
  }) %>%
  post("/brapi/v1/allelematrix-search/tsv/?", function(req, res, err){
    process_allelematrix_search_format(req, res, err)
  }) %>%

  put("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  # post("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
  #   res$set_status(501)
  # }) %>%
  delete("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  })
