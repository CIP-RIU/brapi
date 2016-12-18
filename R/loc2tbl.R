loc2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(res)
  dat <- jsonlite::toJSON(lst$result)

  if (rclass == 'data.frame') {
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)
  }
  if (rclass == 'tibble') {
    res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
    res <- tibble::as_tibble(res)
  }

  res
}
