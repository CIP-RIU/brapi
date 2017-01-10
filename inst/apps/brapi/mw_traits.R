
traits_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/traits.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)


traits_list = function(traitDbId = "all", page = 0, pageSize = 1000){


  if(traitDbId != "all") {
    traits_data <- traits_data[traits_data$traitDbId == traitDbId, ]
    if(nrow(traits_data) == 0) return(NULL)
  }


  # paging here after filtering
  pg = paging(traits_data, page, pageSize)
  traits_data <- traits_data[pg$recStart:pg$recEnd, ]

  n = nrow(traits_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- traits_data[i, ] %>% as.list
    out[[i]]$observationVariables = safe_split(out[[i]]$observationVariables, ";")  %>% as.list
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination
  out
}


traits = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(traits_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list()
)



process_traits <- function(req, res, err){
  traitDbId = basename(req$path)
  prms <- names(req$params)

  #message(traitDbId)
  traitDbId = ifelse(traitDbId != "traits", traitDbId, "all")
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)

  #message(traitDbId)

  traits$result$data = traits_list(traitDbId, page, pageSize)
  traits$metadata$pagination = attr(traits$result$data, "pagination")#,

  if(is.null(traits$result$data)){
    res$set_status(404)
    traits$metadata <-
      brapi_status(100,"No matching results.!"
                   , traits$metadata$status)
    traits$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(traits)

}


mw_traits <<-
  collector() %>%
  get("/brapi/v1/traits[/]?", function(req, res, err){
    process_traits(req, res, err)
  })  %>%
  put("/brapi/v1/traits[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/traits[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/traits[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%

  get("/brapi/v1/traits/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    process_traits(req, res, err)
  })  %>%
  put("/brapi/v1/traits/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/traits/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/traits/[0-9a-zA-Z]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })


