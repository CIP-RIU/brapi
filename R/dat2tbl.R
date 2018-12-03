dat2tbl <- function(res, rclass = "tibble", brapi_class = "ba", result_level = "data") {
  if (rclass == "json") {
    return(jsonlite::prettify(txt = res))
  }
  lst <- jsonlite::fromJSON(txt = res)
  if(result_level == "data") {
    dat <- jsonlite::toJSON(x = lst$result$data)
  }
  if(result_level == "result"){
    dat <- jsonlite::toJSON(x = lst$result)
  }
  if(result_level == "progeny"){
    dat <- jsonlite::toJSON(x = lst$result$progeny)
    germplasmDbId <- lst$result$germplasmDbId
    defaultDisplayName <- lst$result$defaultDisplayName
    np <- max(length(lst$result$progeny), 1)
    dat1 <- as.data.frame(cbind(germplasmDbId = rep(germplasmDbId, np),
                          defaultDisplayName = rep(defaultDisplayName, np)))


  }

  if (rclass == "list") {
    return(jsonlite::fromJSON(txt = res, simplifyVector = FALSE))
  }
  if (rclass == "vector") {
    return(jsonlite::fromJSON(txt = dat, simplifyVector = TRUE))
  }
  if (rclass == "data.frame") {
    res <- jsonlite::fromJSON(txt = dat,
                      simplifyDataFrame = TRUE) %>% as.data.frame
  }
  if (rclass == "tibble") {
    res <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE,
                              flatten = TRUE)
    res <- tibble::as_tibble(x = res)
  }
  if(result_level == "progeny") {
    if(nrow(res) > 0) {
      names(res) <- paste0("progeny.", names(res))
      res <- cbind(dat1, res)
    } else {
      res <- dat1
    }
  }
  attr(x = res, which = "metadata") <- lst$metadata
  class(res) <- c(class(res), brapi_class)
  return(res)
}
