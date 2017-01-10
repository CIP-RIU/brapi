dat2tbl <- function(res, rclass = "tibble", brapi_class = "brapi") {
  if(!rclass %in% c("json", "list", "tibble", "data.frame", "vector") ) {
    rclass = "json"
  }
  if (rclass == "json") return(jsonlite::prettify(res))

  lst <- jsonlite::fromJSON(res)
  dat <- jsonlite::toJSON(lst$result$data)



  if (rclass == "list") {
    return(jsonlite::fromJSON(res, simplifyVector = FALSE))
  }
  if (rclass == "vector") {
    return(jsonlite::fromJSON(dat, simplifyVector = TRUE))
  }
  if (rclass == 'data.frame') {
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE) %>% as.data.frame
    #res <- tibble::as_data_frame(res)
  }
  if (rclass == 'tibble') {
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
    res <- tibble::as_tibble(res)
  }
  attr(res, "metadata") <- lst$metadata
  class(res) = c(class(res), brapi_class)
  res
}
