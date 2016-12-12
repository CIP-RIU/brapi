#
# source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
# source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))
# source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
#

markers_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/markers.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

markers_list = function(markersDbId = NA, name = "none",
                        matchMethod = "exact", include = TRUE, type = "all",
                        page = 0, pageSize = 1000){
  #message(paste("Marker:", markersDbId))
  name = ifelse(is.character(name), name, "none")
  matchMethod = ifelse(matchMethod %in% c("exact", "case_insensitive", "wildcard"),
                       matchMethod, "exact")
  include = ifelse(is.logical(include), as.logical(include), TRUE)
  type = ifelse(is.character(type), type, "all")
  page = ifelse(is.integer(page), as.integer(page), 0)
  pageSize = ifelse(is.integer(pageSize), as.integer(pageSize), 1000)

  if (is.na(markersDbId)){

    if (matchMethod == 'exact') {
      markers_data = markers_data[markers_data$defaultDisplayName == name, ]
      if(nrow(markers_data) == 0) return(NULL)
    }
    if (matchMethod == 'wildcard') {
      name = stringr::str_replace(name, "\\%", "\\*")
      #message(name)
      markers_data = markers_data[grep(name, markers_data$defaultDisplayName), ]
      #message(markers_data$defaultDisplayName)
      if(nrow(markers_data) == 0) return(NULL)
    }
    if (matchMethod == 'case_insensitive') {
      name = toupper(name)
      markers_data = markers_data[toupper(markers_data$defaultDisplayName) == name, ]
      if(nrow(markers_data) == 0) return(NULL)
    }

    if(type != "all"){
      markers_data = markers_data[stringr::str_detect(markers_data$type, type), ]
      if(nrow(markers_data) == 0) return(NULL)
    }

    if(!include) {
      markers_data = markers_data[, !names(markers_data) %in% "synonyms"]
      if(nrow(markers_data) == 0) return(NULL)
    }



    # paging here after filtering
  } else {
    markers_data = markers_data[markersDbId, ]
    if (nrow(markers_data) == 0) return(NULL)
  }

  pg = paging(markers_data, page, pageSize)
  markers_data <- markers_data[pg$recStart:pg$recEnd, ]

  n = nrow(markers_data)
  #message(n)
  out = list(n)
  for (i in 1:n){
    out[[i]] <- as.list(markers_data[i, ])
    if (!is.na(markersDbId)){
      if (include) out[[i]]$synonyms = out[[i]]$synonyms %>% safe_split()
    }
    # out[[i]]$refAlt = out[[i]]$refAlt %>% safe_split()
    # out[[i]]$analysisMethods = out[[i]]$analysisMethods %>% safe_split()
  }

  attr(out, "pagination") = pg$pagination
  out
  out
}


markers = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(markers_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = markers_list())
)


process_markers <- function(req, res, err){
  prms <- names(req$params)

  name = ifelse('name' %in% prms, req$params$name, "none")
  matchMethod = ifelse('matchMethod' %in% prms,
                       req$params$matchMethod, "exact")
  include = ifelse('include' %in% prms, as.logical(req$params$include), TRUE)
  type = ifelse('type' %in% prms, req$params$type, "all")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)


  markers$result$data = markers_list(NA,
    name, matchMethod, include, type, page, pageSize)
  markers$metadata$pagination = attr(markers$result$data, "pagination")


  if(is.null(markers$result$data)){
    res$set_status(404)
    markers$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(markers)
}

process_single_marker <- function(req, res, err){
  #message(is.integer(basename(req$path)))
  markersDbId <- as.integer(basename(req$path))
  #message(paste("prm: ", markersDbId))
  if(markersDbId <= nrow(markers_data)){
    markers$result$data = markers_list(markersDbId)
    markers$metadata$pagination = NULL
  } else {
    markers$result$data = NULL
  }

  if(is.null(markers$result$data)){
    res$set_status(404)
    markers$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(markers)
}


mw_markers <<-
  collector() %>%
  get("/brapi/v1/markers[/]?", function(req, res, err){
    process_markers(req, res, err)
  }) %>%
  put("/brapi/v1/markers[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/markers[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/markers[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%

  #collector() %>%
  get("/brapi/v1/markers/[0-9]{1,12}[/]?", function(req, res, err){
    process_single_marker(req, res, err)
  }) %>%
  put("/brapi/v1/markers/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/markers/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/markers/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })
