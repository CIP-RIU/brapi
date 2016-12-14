library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))

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


allelematrix_search_list = function(markerprofilesDbId = 0, markerDbId = 0,
                                  unknownString = "empty_string", expandHomozygotes = TRUE,
                                  sepPhased ="empty_string", sepUnphased ="empty_string",
                                  page = 0, pageSize = 1000){

  if(markerprofilesDbId > 0){
    allelematrix_search_data <- allelematrix_search_data[allelematrix_search_data$markerProfilesDbId == markerprofilesDbId, ]
  }
  if(nrow(allelematrix_search_data) == 0) return(NULL)
  if(!any(markerprofilesDbId == allelematrix_search_alleles_data$markerprofilesDbId)) return(NULL)

  markerDbId <- tryCatch({safe_split(markerDbId, ",") %>% as.integer()}, error = function(e){NA})

  if(!is.na(markerDbId) & is.integer(markerDbId)) {
    allelematrix_search_alleles_data <- allelematrix_search_alleles_data[
      allelematrix_search_alleles_data$markerDbId %in% markerDbId, ]
  }
  if(nrow(allelematrix_search_alleles_data) == 0) return(NULL)
  x <- allelematrix_search_alleles_data[allelematrix_search_alleles_data$markerprofilesDbId == markerprofilesDbId, c(1,2,4)]
  if(nrow(x) == 0) return(NULL)

  # paging here after filtering
  pg = paging(x, page, pageSize)
  x <- x[pg$recStart:pg$recEnd, ]

  allelematrix_search_data = allelematrix_search_data[, !names(allelematrix_search_data) %in% c("synonyms", "sampleDbId", "studyDbId", "resultCount" )]
  #n = nrow(allelematrix_search_data)
  #message(n)
  #out = list(n)
  out = list()
  #for (i in 1:n){

    if(!is.null(allelematrix_search_alleles_data)) {

      #y <- sapply(x, function(x) ifelse(is.na(x), "", x))
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
   #out$1 <- NULL
  #}

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
  result = allelematrix_search_list()
)


process_allelematrix_search <- function(req, res, err){
  prms <- names(req$params)

  markerprofilesDbId = ifelse('markerprofileDbId' %in% prms, req$params$markerprofileDbId, 0)
  markerDbId = ifelse('markerDbId' %in% prms, req$params$markerDbId, "")
  unknownString = ifelse('unknownString' %in% prms, req$params$unknownString, "empty_string")
  expandHomozygotes = ifelse('expandHomozygotes' %in% prms, req$params$expandHomozygotes, TRUE)
  sepPhased = ifelse('sepPhased' %in% prms, req$params$sepPhased, 0)
  sepUnphased = ifelse('sepUnphased' %in% prms, req$params$sepUnphased, 0)
  format = ifelse('format' %in% prms, req$params$format, "json")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 10000)

  #message(germplasmDbId)
  #message(markerprofilesDbId)

  allelematrix_search$result$data = allelematrix_search_list(
    markerprofilesDbId, markerDbId,
    unknownString, expandHomozygotes, sepPhased, sepUnphased,
    page, pageSize)
  allelematrix_search$metadata$pagination = attr(allelematrix_search$result$data, "pagination")


  if(is.null(allelematrix_search$result$data)){
    res$set_status(404)
    allelematrix_search$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(allelematrix_search)
}


mw_allelematrix_search <<-
  collector() %>%
  get("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    process_allelematrix_search(req, res, err)
  }) %>%
  put("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(501)
  }) %>%
  delete("/brapi/v1/allelematrix-search[/]?", function(req, res, err){
    res$set_status(405)
  })
