# source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
# source(system.file("apps/brapi/utils/paging.R", package = "brapi"))


locations_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/locations.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


locations_additionalInfo_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/locations_additionalinfo.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)


locations_list = function(locationType = "all", page = 0, pageSize = 100){
  if(is.null(locations_data)) return(NULL)
  if(locationType != "all") {
    locations_data = locations_data[
      stringr::str_detect(locations_data$locationType, locationType), ]
    if(nrow(locations_data) == 0) return(NULL)
  }

  # paging here after filtering
  pg = paging(locations_data, page, pageSize)
  locations_data <- locations_data[pg$recStart:pg$recEnd, ]

  n = nrow(locations_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- locations_data[i, ]
    additionalInfo =
       locations_additionalInfo_data[locations_additionalInfo_data$locationDbId == i,
                                     -c(1)]
    if(nrow(additionalInfo) == 0) {
      additionalInfo = NULL
    } else {
      additionalInfo = additionalInfo[, !is.na(additionalInfo)  %>% as.logical() ]
      additionalInfo = as.list(additionalInfo)
    }
    out[[i]]$additionalInfo = list(additionalInfo)
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination
  out
}


locations = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(locations_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = locations_data
)



process_locations <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)
  locationType = ifelse('locationType' %in% prms, req$params$locationType, "all")


  locations$result = locations_list(locationType, page, pageSize)
  locations$metadata = list(pagination = attr(locations$result, "pagination"),
                                       status = attr(locations$result, "status"),
                                       datafiles = list())

  if(is.null(locations$result)){
    res$set_status(404)
    locations$metadata <-
      brapi_status(100,"No matching results for lcoationType!"
                   , locations$metadata$status)
    locations$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(locations)

}




mw_locations <<-
  collector() %>%
  get("/brapi/v1/locations[/]?", function(req, res, err){
    process_locations(req, res, err)
  })  %>%
  put("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/locations[/]?", function(req, res, err){
    res$set_status(405)
  })
