
maps_positions_range_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/maps_positions.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

maps_positions_range_list = function(mapDbId = 0, linkageGroupId = 0,
                                     min =0, max = 1000,
                               page = 0, pageSize = 100){
  if(is.null(maps_positions_range_data)) return(NULL)
  if(mapDbId > 0) {
    maps_positions_range_data = maps_positions_range_data[maps_positions_range_data$mapDbId == mapDbId, ]
    if(nrow(maps_positions_range_data) == 0) return(NULL)
  }
  if(all(linkageGroupId > 0)) {
    maps_positions_range_data = maps_positions_range_data[maps_positions_range_data$linkageGroupId == linkageGroupId, ]
    if(nrow(maps_positions_range_data) == 0) return(NULL)
  }

  if(all(c(min, max) >= 0)) {
    maps_positions_range_data = maps_positions_range_data[maps_positions_range_data$location >= min & maps_positions_range_data$location <= max, ]
    if(nrow(maps_positions_range_data) == 0) return(NULL)
  }


  # paging here after filtering
  pg = paging(maps_positions_range_data, page, pageSize)
  # omit mapDbId (1st column) for return object in this case
  maps_positions_range_data <- maps_positions_range_data[pg$recStart:pg$recEnd, 2:4]

  n = nrow(maps_positions_range_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(maps_positions_range_data[i, ])
  }

  attr(out, "pagination") = pg$pagination
  out
}


maps_positions_range = list(
  metadata = list(
    pagination = list(
      pageSize = 30,
      currentPage = 0,
      totalCount = nrow(maps_positions_range_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = maps_positions_range_list())
)


process_maps_positions_range <- function(req, res, err){
  prms <- names(req$params)
  mapDbId <- basename(stringr::str_replace(req$path, "/positions/[0-9]{1,12}[/]?", "")) %>%
    as.integer()
  linkageGroupId = basename(req$path)


  amin = ifelse('min' %in% prms, as.integer(req$params$min), 0)
  amax = ifelse('max' %in% prms, as.integer(req$params$max), 1000)

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 30)
  message("===")
  message(paste("mapDbId", mapDbId))
  message(linkageGroupId)
  message(amin)
  message(amax)
  message(page)
  message(pageSize)

  maps_positions_range$result$data = maps_positions_range_list(mapDbId, linkageGroupId, amin, amax, page, pageSize)
  maps_positions_range$metadata$pagination = attr(maps_positions_range$result$data, "pagination")

  if(is.null(maps_positions_range$result$data)){
    res$set_status(404)
    maps_positions_range$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(maps_positions_range)
}

mw_maps_positions_range <<-
  collector() %>%
  get("/brapi/v1/maps/[0-9]{1,12}/positions/[0-9]{1,12}[/]?", function(req, res, err){
    process_maps_positions_range(req, res, err)
  })  %>%
  put("/brapi/v1/maps/[0-9]{1,12}/positions/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/maps/[0-9]{1,12}/positions/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/maps/[0-9]{1,12}/positions/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })
