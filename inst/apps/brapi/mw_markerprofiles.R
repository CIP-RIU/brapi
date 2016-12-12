markerprofiles_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/markerprofiles.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

markerprofiles_list = function(germplasmDbId = 0, studyDbId = 0,
                        sampleDbId = 0, extractDbId = 0, method = "all",
                        page = 0, pageSize = 1000){

  markerprofiles_data <- markerprofiles_data[markerprofiles_data$germplasmDbId == germplasmDbId, ]
  #nrow(markerprofiles_data) %>% message
  if(nrow(markerprofiles_data) == 0) return(NULL)

  if(studyDbId > 0 ) markerprofiles_data <- markerprofiles_data[markerprofiles_data$studyDbId == studyDbId, ]
  if(sampleDbId > 0 ) markerprofiles_data <- markerprofiles_data[markerprofiles_data$sampleDbId == sampleDbId, ]
  if(extractDbId > 0 ) markerprofiles_data <- markerprofiles_data[markerprofiles_data$extractDbId == extractDbId, ]
  if(method != "all" ) markerprofiles_data <- markerprofiles_data[markerprofiles_data$analysisMethod == method, ]

  if(nrow(markerprofiles_data) == 0) return(NULL)
  # paging here after filtering
  pg = paging(markerprofiles_data, page, pageSize)
  markerprofiles_data <- markerprofiles_data[pg$recStart:pg$recEnd, ]

  n = nrow(markerprofiles_data)
  #message(n)
  out = list(n)
  for (i in 1:n){
    out[[i]] <- as.list(markerprofiles_data[i, ])
  }

  attr(out, "pagination") = pg$pagination
  out
  out
}


markerprofiles = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(markerprofiles_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = markerprofiles_list())
)


process_markerprofiles <- function(req, res, err){
  prms <- names(req$params)

  germplasmDbId = ifelse('germplasm' %in% prms, req$params$germplasm, 0)
  studyDbId = ifelse('studyDbId' %in% prms, req$params$studyDbId, 0)
  sampleDbId = ifelse('sample' %in% prms, req$params$sample, 0)
  extractDbId = ifelse('extract' %in% prms, req$params$extract, 0)
  analysisMethod = ifelse('method' %in% prms, req$params$method, "all")

  # message(paste("germplasm", germplasmDbId))
  # message(paste("study", studyDbId))
  # message(paste("sample", sampleDbId))
  # message(paste("extract", extractDbId))
  # message(paste("method", analysisMethod))

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)


  markerprofiles$result$data = markerprofiles_list(
    germplasmDbId, studyDbId, sampleDbId, extractDbId, analysisMethod,
    page, pageSize)
  markerprofiles$metadata$pagination = attr(markerprofiles$result$data, "pagination")


  if(is.null(markerprofiles$result$data)){
    res$set_status(404)
    markerprofiles$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(markerprofiles)
}


mw_markerprofiles <<-
  collector() %>%
  get("/brapi/v1/markerprofiles[/]?", function(req, res, err){
    process_markerprofiles(req, res, err)
  }) %>%
  put("/brapi/v1/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/markerprofiles[/]?", function(req, res, err){
    res$set_status(405)
  })
