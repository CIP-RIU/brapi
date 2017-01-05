sov2tbl <- function(res, rclass){

  df = jsonlite::fromJSON(res, simplifyDataFrame = TRUE, flatten = TRUE)
  out = df$result$data

  out = as.data.frame(cbind(
    studyDbId = rep(df$result$studyDbId, nrow(out)),
    trialName = rep(df$result$trialName, nrow(out)),
    out
  ), stringsAsFactors = FALSE)

  out$studyDbId = as.character(out$studyDbId)
  out$trialName = as.character(out$trialName)

  out$synonyms <- sapply(out$synonyms, paste, collapse = ";")
  out$contextOfUse <- sapply(out$contextOfUse, paste, collapse = ";")
  out$trait.synonyms <- sapply(out$trait.synonyms, paste, collapse = ";")
  out$trait.alternativeAbbreviations <- sapply(out$trait.alternativeAbbreviations, paste, collapse = ";")

  out$scale.validValues.categories <- sapply(out$scale.validValues.categories, paste, collapse = ";")

  if(rclass == "tibble") out = tibble::as_tibble(out)
  out
}
