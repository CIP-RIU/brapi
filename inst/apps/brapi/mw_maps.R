library(jug)
library(jsonlite)

source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))


maps_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/maps.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
}, error = function(e) {
  NULL
}
)

maps_list = function(species = "all", type = "all", page = 0, pageSize = 100){
  if(is.null(maps_data)) return(NULL)
  if(type != "all") {
    maps_data = maps_data[stringr::str_detect(maps_data$type, type), ]
    if(nrow(maps_data) == 0) return(NULL)
  }
  if(species != "all") {
    maps_data = maps_data[stringr::str_detect(maps_data$species, species), ]
    if(nrow(maps_data) == 0) return(NULL)
  }

  # paging here after filtering
  pg = paging(maps_data, page, pageSize)
  maps_data <- maps_data[pg$recStart:pg$recEnd, ]

  n = nrow(maps_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(maps_data[i, ])
  }

  attr(out, "pagination") = pg$pagination
  out
}


maps = list(
  metadata = list(
    pagination = list(
      pageSize = 30,
      currentPage = 0,
      totalCount = nrow(maps_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = maps_list())
)


process_maps <- function(req, res, err){
  prms <- names(req$params)
  species = ifelse('species' %in% prms, req$params$species, "all")
  type = ifelse('type' %in% prms, req$params$type, "all")

  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 30)

  maps$result$data = maps_list(species, type, page, pageSize)
  maps$metadata$pagination = attr(maps$result$data, "pagination")


  if(is.null(maps$result$data)){
    res$set_status(404)
    maps$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(maps)
}

mw_maps <<-
  collector() %>%
  get("/brapi/v1/maps[/]?", function(req, res, err){
    process_maps(req, res, err)
  })  %>%
  put("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/maps[/]?", function(req, res, err){
    res$set_status(405)
  })
