# library(jug)
# library(jsonlite)
#
# source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
# source(system.file("apps/brapi/utils/paging.R", package = "brapi"))
# source(system.file("apps/brapi/utils/safe_split.R", package = "brapi"))

maps_positions_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/maps_positions.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

maps_positions_list = function(mapDbId = 0, linkageGroupId = 0,
                               page = 0, pageSize = 100){
  if(is.null(maps_positions_data)) return(NULL)
  if(mapDbId > 0) {
    maps_positions_data = maps_positions_data[maps_positions_data$mapDbId == mapDbId, ]
    if(nrow(maps_positions_data) == 0) return(NULL)
  }
  if(all(linkageGroupId > 0)) {
    maps_positions_data = maps_positions_data[maps_positions_data$linkageGroupId %in% linkageGroupId, ]
    if(nrow(maps_positions_data) == 0) return(NULL)
  }

  # paging here after filtering
  pg = paging(maps_positions_data, page, pageSize)
  # omit mapDbId (1st column) for return object in this case
  maps_positions_data <- maps_positions_data[pg$recStart:pg$recEnd, 2:5]

  n = nrow(maps_positions_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(maps_positions_data[i, ])
  }

  attr(out, "pagination") = pg$pagination
  out
}


maps_positions = list(
  metadata = list(
    pagination = list(
      pageSize = 30,
      currentPage = 0,
      totalCount = nrow(maps_positions_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = maps_positions_list())
)


process_maps_positions <- function(req, res, err){
  prms <- names(req$params)
  mapDbId <- basename(stringr::str_replace(req$path, "/positions[/]?", "")) %>%
    as.integer()

  #message(names(req$params))
  # message(req$params$linkageGroupId)
  linkageGroupId = ifelse('linkageGroupId' %in% prms, req$params$linkageGroupId, 0)
  linkageGroupId = req$params[names(req$params) == "linkageGroupId"] %>% paste(collapse = ",")
  #message(linkageGroupId)
  linkageGroupId = safe_split(linkageGroupId, ",")

  #message(linkageGroupId)

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 30)

  maps_positions$result$data = maps_positions_list(mapDbId, linkageGroupId, page, pageSize)
  maps_positions$metadata$pagination = attr(maps_positions$result$data, "pagination")


  if(is.null(maps_positions$result$data)){
    res$set_status(404)
    maps_positions$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(maps_positions)
}

mw_maps_positions <<-
  collector() %>%
  get("/brapi/v1/maps/[0-9]{1,12}/positions[/]?", function(req, res, err){
    process_maps_positions(req, res, err)
  })  %>%
  put("/brapi/v1/maps/[0-9]{1,12}/positions[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/maps/[0-9]{1,12}/positions[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/maps/[0-9]{1,12}/positions[/]?", function(req, res, err){
    res$set_status(405)
  })
