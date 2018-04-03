dat2tbl <- function(res, rclass = "tibble", brapi_class = "ba") {
  if (rclass == "json") {
    return(jsonlite::prettify(txt = res))
  }
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
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
    res <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)
    res <- tibble::as_tibble(x = res)
  }
  attr(x = res, which = "metadata") <- lst$metadata
  class(res) <- c(class(res), brapi_class)
  return(res)
}
