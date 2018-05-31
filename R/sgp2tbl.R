sgp2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE, flatten = TRUE)
  if("snynonyms" %in% names(df)) {
    df$synonyms <- lapply(X = df$synonyms, FUN = paste, collapse = "; ")
  }
  df <- as.data.frame(x = cbind(studyDbId = rep(lst$result$studyDbId, nrow(df)),
                                trialName = rep(lst$result$trialName, nrow(df)),
                                df),
                      stringsAsFactors = FALSE)
  if (rclass == "tibble") {
    df <- tibble::as_tibble(x = df)
  }
  return(df)
}
