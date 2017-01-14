lyt2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result$data)
    df <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)
    if (rclass == "tibble") {
        df <- tibble::as_tibble(df)
    }
    df
}
