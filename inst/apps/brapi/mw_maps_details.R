
maps_details_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/maps.csv", package = "brapi"),
                  stringsAsFactors = FALSE)[, c(1, 2, 4, 5)]
}, error = function(e) {
  NULL
}
)

maps_details_data_lg = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/maps_positions.csv", package = "brapi"),
                  stringsAsFactors = FALSE)[, c(1, 2, 4, 5)]
}, error = function(e) {
  NULL
}
)


maps_details_list = function(mapDbId = 0){
  if(is.null(maps_details_data)) return(NULL)
  if(mapDbId == 0) return(NULL)
  maps_details_data = maps_details_data[maps_details_data$mapDbId == mapDbId, ]
  if(nrow(maps_details_data) == 0 | nrow(maps_details_data) > 1) return(NULL)

  maps_details_data_lg = maps_details_data_lg[maps_details_data_lg$mapDbId == mapDbId, ]

  #n = nrow(maps_details_data)
  nn = max(unique(maps_details_data_lg$linkageGroupId))
  out = list(1)
  #for(i in 1:n){
    out[[1]] <- as.list(maps_details_data[1, ])

    if(!is.null(maps_details_data_lg)) {
        out[[1]]$linkageGroups = list(nn)
        for (j in 1:nn) {
          out2 = list(
            linkageGroupId =
              unique(maps_details_data_lg[maps_details_data_lg$linkageGroupId == j, 4]),
              numberMarkers =
               nrow(
                maps_details_data_lg[maps_details_data_lg$linkageGroupId == j, ]),
              maxPosition =
              max(maps_details_data_lg[maps_details_data_lg$linkageGroupId == j, c("location")])
          )
          out[[1]]$linkageGroups[[j]] <- out2
        }
    }
  #}

  # attr(out, "pagination") = list(
  #   pageSize = 0,
  #   currentPage = 0,
  #   totalCount = 0,
  #   totalPages = 0
  # )
  out
}


maps_details = list(
  metadata = list(
    pagination = list(
      pageSize = 0,
      currentPage = 0,
      totalCount = 0,
      totalPages = 0
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(linkageGroups = maps_details_list())
)


process_maps_details <- function(req, res, err){
  mapDbId <- basename(req$path) %>% as.integer()

  #message(mapDbId)
  maps_details$result = maps_details_list(mapDbId)
  #maps_details$metadata$pagination = attr(maps_details$result$linka, "pagination")


  if(is.null(maps_details$result)){
    res$set_status(404)
    maps_details$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(maps_details)
}

mw_maps_details <<-
  collector() %>%
  get("/brapi/v1/maps/[0-9]{1,12}[/]", function(req, res, err){
    process_maps_details(req, res, err)
  })  %>%
  put("/brapi/v1/maps/[0-9]{1,12}[/]", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/maps/[0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/maps/[0-9]{1,12}[/]", function(req, res, err){
    res$set_status(405)
  })
