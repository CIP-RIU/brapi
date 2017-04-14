sgp2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result$data)
    df <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE, flatten = TRUE)
    
    df$synonyms <- lapply(df$synonyms, paste, collapse = "; ")
    
    df <- as.data.frame(cbind(studyDbId = rep(lst$result$studyDbId, nrow(df)), trialName = rep(lst$result$trialName, nrow(df)), df), stringsAsFactors = FALSE)
    
    if (rclass == "tibble") {
        df <- tibble::as_tibble(df)
    }
    
    return(df)
}
