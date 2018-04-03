sov2tbl <- function(res,
                    rclass,
                    variable = FALSE) {
  df <- jsonlite::fromJSON(txt = res, simplifyDataFrame = TRUE,
                           flatten = TRUE)
  out <- df$result$data

  if (rclass == "tibble") {
    out <- tibble::as_tibble(out, validate = FALSE)
  }
  return(out)
}
