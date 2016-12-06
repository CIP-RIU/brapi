# library(jug)
# library(jsonlite)
# source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
# source(system.file("apps/brapi/utils/paging.R", package = "brapi"))

germplasm_search_data = tryCatch({
  x <- read.csv(system.file("apps/brapi/data/germplasm-search.csv", package = "brapi"), stringsAsFactors = FALSE)
  x <- sapply(x, function(x) ifelse(is.na(x), "", x))
  x <- x %>% as.data.frame(stringsAsFactors = FALSE)
  x$germplasmDbId <- as.integer(x$germplasmDbId)
  x$biologicalStatusOfAccessionCode <- as.integer(x$biologicalStatusOfAccessionCode)
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
                                 germplasmDbId = 0,
                                 germplasmName = "none",
                                 germplasmPUI = "none",
                                 page=0, pageSize = 100){
  if(is.null(germplasm_search_data)) return(NULL)
  if(germplasmDbId > 0){
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
    out[[i]]$germplasmDbId <- as.integer(out[[i]]$germplasmDbId)

    if(!is.null(germplasm_donor)){
      x <- germplasm_donor[as.integer(germplasm_donor$germplasmDbId) == out[[i]]$germplasmDbId, 2:4 ]
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
    status = list(),
    datafiles = list()
  ),
  result = list(data = germplasm_search_list())
)
