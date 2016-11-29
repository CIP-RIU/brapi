library(jug)
library(jsonlite)
source(system.file("apps/brapi/brapi_status.R", package = "brapi"))

programs_data = tryCatch({
  read.csv(system.file("apps/brapi/data/programs.csv", package = "brapi"), stringsAsFactors = FALSE)
}, error = function(e){
  NULL
}
)

prg_list = function(abbr = NULL, prg = NULL){
  if(is.null(programs_data)) return(NULL)
  if(!is.null(abbr)){
    programs_data = programs_data[programs_data$abbreviation == abbr, ]
    if(nrow(programs_data) == 0) return(NULL)
  }

  if(!is.null(prg)){
    programs_data = programs_data[programs_data$name == prg, ]
    if(nrow(programs_data) == 0) return(NULL)
  }

  n = nrow(programs_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(programs_data[i, ])
  }
  out
}


programs = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 1,
      totalCount = nrow(programs_data),
      totalPages = 1
    ),
    status = NULL,
    datafiles = NULL
  ),
  result = list(data = prg_list())
)


process_programs <- function(req, res, err){
  prms <- names(req$params)
  if('abbreviation' %in% prms){
    programs$result$data = prg_list(req$params$abbreviation)
  }
  if('programName' %in% prms){
    programs$result$data = prg_list(prg = req$params$programName)
  }

  if('page' %in% prms | 'pageSize' %in% prms){
   programs$metadata <- brapi_status(code = 200,
          "Parameters 'page' and 'pageSize' are not implemented." )
  }


  if(is.null(programs$result$data)){
    res$set_status(404)
    programs$metadata <- brapi_status(100, "No matching results!")
  }
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
