library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))

programs_data = tryCatch({
  read.csv(system.file("apps/brapi/data/programs.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e){
  NULL
}
)

programs_list = function(abbr = "none", prg = "none", page=0, pageSize = 100){
  if(is.null(programs_data)) return(NULL)
  if(abbr != "none"){
    programs_data = programs_data[programs_data$abbreviation == abbr, ]
    if(nrow(programs_data) == 0) return(NULL)
  }

  if(prg != "none") {
    programs_data = programs_data[programs_data$name == prg, ]
    if(nrow(programs_data) == 0) return(NULL)
  }
  # paging here after filtering
  pg = paging(programs_data, page, pageSize)
  programs_data <- programs_data[pg$recStart:pg$recEnd, ]

  n = nrow(programs_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(programs_data[i, ])
  }
  attr(out, "pagination") = pg$pagination
  out
}


programs = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 0,
      totalCount = nrow(programs_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = list(data = programs_list())
)


process_programs <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)
  abbreviation = ifelse('abbreviation' %in% prms, req$params$abbreviation, "none")
  programName = ifelse('programName' %in% prms, req$params$programName, "none")

  programs$result$data = programs_list(abbreviation, programName, page, pageSize)
  programs$metadata$pagination = attr(programs$result$data, "pagination")

  if(is.null(programs$result$data)){
    res$set_status(404)
    programs$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(programs)

}

mw_programs <<-
  collector() %>%
  get("/brapi/v1/programs[/]?", function(req, res, err){
    process_programs(req, res, err)
  }) %>%
  put("/brapi/v1/programs[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/programs[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/programs[/]?", function(req, res, err){
    res$set_status(405)
  })
