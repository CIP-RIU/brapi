
variables_ontologies_data = tryCatch({
  res <- read.csv(system.file("apps/brapi/data/variables_ontology.csv", package = "brapi"),
                  stringsAsFactors = FALSE)
  res
}, error = function(e) {
  NULL
}
)


variables_ontologies_list = function(page = 0, pageSize = 1000){

  # paging here after filtering
  pg = paging(variables_ontologies_data, page, pageSize)
  variables_ontologies_data <- variables_ontologies_data[pg$recStart:pg$recEnd, ]

  n = nrow(variables_ontologies_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- variables_ontologies_data[i, ] %>% as.list
  }

  attr(out, "status") = list()
  attr(out, "pagination") = pg$pagination
  out
}


variables_ontologies = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(variables_ontologies_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list()
)



process_variables_ontologies <- function(req, res, err){
  prms <- names(req$params)

  #message(traitDbId)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 1000)

  variables_ontologies$result$data = variables_ontologies_list(page, pageSize)
  variables_ontologies$metadata$pagination = attr(variables_ontologies$result$data, "pagination")#,

  if(is.null(variables_ontologies$result$data)){
    res$set_status(404)
    variables_ontologies$metadata <-
      brapi_status(100,"No matching results.!"
                   , variables_ontologies$metadata$status)
    variables_ontologies$result = list()
  }

  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(variables_ontologies)

}


mw_variables_ontologies <<-
  collector() %>%
  get("/brapi/v1/ontologies[/]?", function(req, res, err){
    process_variables_ontologies(req, res, err)
  })  %>%
  put("/brapi/v1/ontologies[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/ontologies[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/ontologies[/]?", function(req, res, err){
    res$set_status(405)
  })

