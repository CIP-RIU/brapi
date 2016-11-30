library(jug)
library(jsonlite)

source(system.file("apps/brapi/brapi_status.R", package = "brapi"))

seasons_data = tryCatch({
  read.csv(system.file("apps/brapi/data/seasons.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e){
  NULL
}
)


seasons_list = function(year = NULL){
  if(is.null(seasons_data)) return(NULL)
  if(!is.null(year)){
    seasons_data = seasons_data[seasons_data$year == year, ]
    if(nrow(seasons_data) == 0) return(NULL)
  }

  n = nrow(seasons_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(seasons_data[i, ])
  }
  out
}


seasons = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 0,
      totalCount = nrow(seasons_data),
      totalPages = 1
    ),
    status = NULL,
    datafiles = list()
  ),
  result = list(data = seasons_list())
)


process_seasons <- function(req, res, err){
  prms <- names(req$params)
  if('year' %in% prms){
    seasons$result$data = seasons_list(req$params$year)
    seasons$metadata$pagination$totalCount = length(seasons$result$data)
  }

  if('page' %in% prms | 'pageSize' %in% prms){
    seasons$metadata <- brapi_status(code = 200,
                                      "Parameters 'page' and 'pageSize' are not implemented." )
  }


  if(is.null(seasons$result$data)){
    res$set_status(404)
    seasons$metadata <- brapi_status(100, "No matching results!")
  }
  res$json(seasons)

}


mw_seasons <<-
  collector() %>%
  get("/brapi/v1/seasons[/]?", function(req, res, err){
    process_seasons(req, res, err)
  })  %>%
  put("/brapi/v1/seasons[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/seasons[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/seasons[/]?", function(req, res, err){
    res$set_status(405)
  })
