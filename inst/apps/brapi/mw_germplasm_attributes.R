library(jug)
library(jsonlite)
source(system.file("apps/brapi/utils/brapi_status.R", package = "brapi"))
source(system.file("apps/brapi/utils/paging.R", package = "brapi"))


germplasm_attributes_data = tryCatch({
  x <- read.csv(system.file("apps/brapi/data/germplasm_attributes.csv",
                       package = "brapi"),
           stringsAsFactors = FALSE)
  x$germplasmDbId <- as.integer(x$germplasmDbId)
  x
}, error = function(e){
  NULL
}
)


germplasm_attributes_list = function(germplasmDbId = 0,
                                     attributeList = "",
                                     page = 0, pageSize = 1000){
  if(is.null(germplasm_attributes_data)) return(NULL)
  if(germplasmDbId > 0){
    germplasm_attributes_data =
      germplasm_attributes_data[
        germplasm_attributes_data$germplasmDbId == germplasmDbId, ]
    if(nrow(germplasm_attributes_data) == 0) return(NULL)
  }

  if(attributeList != ""){
    if(stringr::str_detect(attributeList, ",")) {
      attributeList = stringr::str_split(attributeList, ",")[[1]]
    }
    attributeList <- attributeList %>% as.integer
    germplasm_attributes_data <- germplasm_attributes_data[
      germplasm_attributes_data$attributeDbId %in% attributeList, ]
  }

  #out <- germplasm_attributes_data$ %>% as.list

  # paging here after filtering
  pg = paging(germplasm_attributes_data, page, pageSize)
  germplasm_attributes_data <- germplasm_attributes_data[pg$recStart:pg$recEnd, ]


  out <- list(
    germplasmDbId = germplasmDbId,
   data = germplasm_attributes_data[, 2:6]
  )

  attr(out, "pagination") = pg$pagination
  out
}


germplasm_attributes = list(
  metadata = list(
    pagination = list(
      pageSize = 1000,
      currentPage = 0,
      totalCount = nrow(germplasm_attributes_data),
      totalPages = 1
    ),
    status = list(),
    datafiles = list()
  ),
  result = germplasm_attributes_list()
)

process_germplasm_attributes <- function(req, res, err){
  prms <- names(req$params)
  page = ifelse('page' %in% prms, as.integer(req$params$page), 0)
  pageSize = ifelse('pageSize' %in% prms, as.integer(req$params$pageSize), 100)
  attributeList = ifelse('attributeList' %in% prms, req$params$attributeList, 0)

  #message(attributeList)

  germplasmDbId <- basename(stringr::str_replace(req$path, "/attributes[/]?", "")) %>%
    as.integer()
  #message(germplasmDbId)

  germplasm_attributes$result = germplasm_attributes_list(germplasmDbId,
                                                          attributeList,
                                                          page, pageSize)
  germplasm_attributes$metadata = list(pagination = attr(germplasm_attributes$result, "pagination"),
                                       status = list(),
                                   datafiles = list())

  if(is.null(germplasm_attributes$result)){
    res$set_status(404)
    germplasm_attributes$metadata <-
      brapi_status(100,"No matching results for germplasmDbId!")
      #result = list()
    germplasm_attributes$result = list()
  }
  message(str(germplasm_attributes$result$data))

  if (is.null(germplasm_attributes$result$data) ||
     is.na(germplasm_attributes$result$data[1,1])) {
    res$set_status(404)
    germplasm_attributes$metadata <-
      brapi_status(110,"No matching results for attributeList!"
                   , germplasm_attributes$metadata$status
                   )
    #result = list()
    germplasm_attributes$result = list()
  }
res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_attributes)

}


mw_germplasm_attributes <<-
  collector() %>%
  get("/brapi/v1/germplasm/[0-9]{1,12}/attributes[/]?", function(req, res, err){
    #res$set_status(501)
    process_germplasm_attributes(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm/[0-9]{1,12}/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm/[0-9]{1,12}/attributes[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/germplasm/[0-9]{1,12}/attributes[/]?", function(req, res, err){
    res$set_status(405)
  })
