lyt2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(res)
  dat <- jsonlite::toJSON(lst$result$dat)

  df = jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)

  if (rclass == 'tibble') {
    df <- tibble::as_tibble(df)
  }

  df
}
