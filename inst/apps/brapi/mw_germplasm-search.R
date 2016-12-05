library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))

germplasm_search_data = tryCatch({
  x <- read.csv(system.file("apps/brapi/data/germplasm-search.csv", package = "brapi"), stringsAsFactors = FALSE)
  x <- sapply(x, function(x) ifelse(is.na(x), "", x))
  x <- x %>% as.data.frame(stringsAsFactors = FALSE)
  x$biologicalStatusOfAccessionCode <- as.integer(x$biologicalStatusOfAccessionCode)
  x$typeOfGermplasmStorageCode <- as.integer(x$typeOfGermplasmStorageCode)
  x

}, error = function(e){
  NULL
}
)

# TODO add donor info!
germplasm_donor = tryCatch({
  x <- read.csv(system.file("apps/brapi/data/germplasm_donors.csv", package = "brapi"), stringsAsFactors = FALSE)
  x <- sapply(x, function(x) ifelse(is.na(x), "", x))
  x <- x %>% as.data.frame(stringsAsFactors = FALSE)
  x
}, error = function(e){
  NULL
}
)


germplasm_search_list = function(
                                 germplasmDbId = "none",
                                 germplasmName = "none",
                                 germplasmPUI = "none",
                                 page=0, pageSize = 100){
  if(is.null(germplasm_search_data)) return(NULL)
  if(germplasmDbId != "none"){
    germplasm_search_data =
      germplasm_search_data[germplasm_search_data$germplasmDbId == germplasmDbId, ]
    if(nrow(germplasm_search_data) == 0) return(NULL)
  }
  if(germplasmName != "none"){
    germplasm_search_data =
      germplasm_search_data[germplasm_search_data$germplasmName == germplasmName, ]
    if(nrow(germplasm_search_data) == 0) return(NULL)
  }

  if(germplasmPUI != "none"){
    germplasm_search_data =
      germplasm_search_data[germplasm_search_data$germplasmPUI == germplasmPUI, ]
    if(nrow(germplasm_search_data) == 0) return(NULL)
  }


  # paging here after filtering
  pg = paging(germplasm_search_data, page, pageSize)
  germplasm_search_data <- germplasm_search_data[pg$recStart:pg$recEnd, ]

  n = nrow(germplasm_search_data)
  out = list(n)
  for(i in 1:n){
    out[[i]] <- as.list(germplasm_search_data[i, ])

    if(!is.null(germplasm_donor)){
      x <- germplasm_donor[germplasm_donor$germplasmDbId == out[[i]]$germplasmDbId, 2:4 ]
      y <- sapply(x, function(x) ifelse(is.na(x), "", x))
      nn <- nrow(y)
      if(!is.null(nn)){
        out[[i]]$donors = list(nn)
        #message(i)
        for (j in 1:nn) {
          out[[i]]$donors[[j]] <- as.list(y[j, ])
        }
      } else {
        out[[i]]$donors <- list(as.list(y))
      }

    }

  }
  attr(out, "pagination") = pg$pagination
  out
}


germplasm_search = list(
  metadata = list(
    pagination = list(
      pageSize = 100,
      currentPage = 0,
      totalCount = nrow(germplasm_search_data),
      totalPages = 1
    ),
    status = NULL,
    datafiles = list()
  ),
  result = list(data = germplasm_search_list())
)


process_germplasm_search <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)
  germplasmDbId = ifelse('germplasmDbId' %in% prms, req$params$germplasmDbId, "none")
  germplasmName = ifelse('germplasmName' %in% prms, req$params$germplasmName, "none")
  germplasmPUI = ifelse('germplasmPUI' %in% prms, req$params$germplasmPUI, "none")

  germplasm_search$result$data =
    germplasm_search_list(
      germplasmDbId, germplasmName, germplasmPUI,
      page, pageSize)
  germplasm_search$metadata$pagination = attr(germplasm_search$result$data, "pagination")

  if(is.null(germplasm_search$result$data)){
    res$set_status(404)
    germplasm_search$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_search)

}

mw_germplasm_search <<-
  collector() %>%
  get("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    process_germplasm_search(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    #res$set_status(405)
    process_germplasm_search(req, res, err)
  }) %>%
  delete("/brapi/v1/germplasm-search[/]?", function(req, res, err){
    res$set_status(405)
  })
