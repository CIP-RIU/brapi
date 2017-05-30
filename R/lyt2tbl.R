lyt2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  if (rclass == "tibble") {
    df <- tibble::as_tibble(x = df)
  }
  return(df)
}
