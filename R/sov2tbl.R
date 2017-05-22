sov2tbl <- function(res,
                    rclass,
                    variable = FALSE) {
  df <- jsonlite::fromJSON(txt = res, simplifyDataFrame = TRUE, flatten = TRUE)
  out <- df$result$data
  if (!variable) {
    out <- as.data.frame(x = cbind(studyDbId = rep(df$result$studyDbId, nrow(out)),
                                   trialName = rep(df$result$trialName, nrow(out)),
                                   out),
                         stringsAsFactors = FALSE)
    out$studyDbId <- as.character(out$studyDbId)
    out$trialName <- as.character(out$trialName)
  }
  out$synonyms <- sapply(X = out$synonyms,
                         FUN = paste,
                         collapse = ";")
  out$contextOfUse <- sapply(X = out$contextOfUse,
                             FUN = paste,
                             collapse = ";")
  out$trait.synonyms <- sapply(X = out$trait.synonyms,
                               FUN = paste,
                               collapse = ";")
  out$trait.alternativeAbbreviations <- sapply(X = out$trait.alternativeAbbreviations,
                                               FUN = paste,
                                               collapse = ";")
  out$scale.validValues.categories <- sapply(X = out$scale.validValues.categories,
                                             FUN = paste,
                                             collapse = ";")
  if (rclass == "tibble") {
    out <- tibble::as_tibble(out, validate = FALSE)
  }
  return(out)
}
