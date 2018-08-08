sov2tbl <- function(res,
                    rclass,
                    variable = FALSE) {
  lst <- jsonlite::fromJSON(txt = res)
  resultJSON <- jsonlite::toJSON(x = lst$result)
  resultList <- jsonlite::fromJSON(txt = resultJSON)
  # split off data from resultList
  dataDF <- resultList$data
  dataDFJSON <- jsonlite::toJSON(x = dataDF)
  # reform flattened dataDF
  dataDF <- jsonlite::fromJSON(txt = dataDFJSON, simplifyDataFrame = TRUE, flatten = TRUE)
  dataDF <- as.data.frame(lapply(X = dataDF,
                                 FUN = function(x) {
                                   if (class(x) == "list") {
                                     x <- sapply(X = x ,
                                                 FUN = paste0,
                                                 collapse = "; ")
                                   } else {
                                     x <- x
                                   }
                                 }),
                          stringsAsFactors = FALSE)
  # remove empty columns from dataDF
  for (i in ncol(dataDF):1) {
    if (class(dataDF[[i]]) == "character" && all(dataDF[[i]] == "")) {
      dataDF[[i]] <- NULL
    }
  }
  # remove data part from resultList
  resultList$data <- NULL
  temp <- NULL
  if (nrow(dataDF) == 1) {
    temp <- as.data.frame(x = resultList,
                          stringsAsFactors = FALSE)
  } else {
    for (i in 1:nrow(dataDF)) {
      temp <- rbind(temp,
                    as.data.frame(x = resultList, stringsAsFactors = FALSE))
    }
  }
  out <- cbind(temp, dataDF)
  if (rclass == "tibble") {
    out <- tibble::as_tibble(out)
  }
  return(out)
}
