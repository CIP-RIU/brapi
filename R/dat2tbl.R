dat2tbl <- function(res, rclass = "tibble") {
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
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
  }
  if (rclass == 'tibble') {
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
    res <- tibble::as_tibble(res)
  }
  attr(res, "metadata") <- lst$metadata
  res
}
