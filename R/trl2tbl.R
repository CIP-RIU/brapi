trl2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    if (length(lst$result) == 0) 
        return(NULL)
    dat <- jsonlite::toJSON(lst$result$data)
    dat <- jsonlite::fromJSON(dat)
    
    nms <- unique(lapply(dat, names) %>% unlist)
    # TODO vectorize the next
    n = length(dat)
    x = character(n)
    for (i in 1:n) {
        x = c(x, names(dat[[i]]$additionalInfo))
    }
    nms <- c(nms, unique(x))
    nms <- nms[!nms %in% c("", "additionalInfo")]
    
    # construct basic data.frame
    
    df <- as.data.frame(matrix(NA, ncol = length(nms), nrow = n), stringsAsFactors = FALSE)
    names(df) <- nms
    names(df)[9:length(nms)] <- paste0("additionalInfo.", nms[9:length(nms)])
    for (i in 1:length(dat)) {
        df[i, 1:7] <- dat[[i]][1:7]
        an <- paste0("additionalInfo.", names(dat[[i]]$additionalInfo))
        if (ncol(dat[[i]]$additionalInfo) > 0) 
            df[i, an] <- dat[[i]]$additionalInfo
    }
    # TODO gather data for studies in separate table and then join; get data of additionalInfo (1st)
    
    dfs = as.data.frame(cbind(trialDbId = character(), studyDbId = character(), studyName = character(), 
        locationName = character()))
    for (i in 1:length(dat)) {
        rec = dat[[i]]$studies[[1]]
        if (nrow(rec) > 0) {
            trialDbId = rep(dat[[i]]$trialDbId, nrow(rec))
            dfr = cbind(trialDbId, rec)
            dfs = rbind(dfs, dfr)
        }
    }
    
    names(dfs)[2:4] = paste0("studies.", names(dfs)[2:4])
    
    out = merge(df, dfs)
    out = out[, -c(8)]
    m = ncol(out)
    n = m - 2
    out = out[, c(1:7, n:m, 8:(n - 1))]
    
    if (rclass == "tibble") 
        out = tibble::as_tibble(out)
    
    
    out
}
