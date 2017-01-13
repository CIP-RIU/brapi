loc2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result)
    dat <- jsonlite::fromJSON(dat)
    
    # get all var names
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
    
    # fill in data in sparse matrix
    for (i in 1:n) {
        # fixed names
        fnms <- names(dat[[i]])[-10]  # exclude field additionalInfo
        df[i, fnms] <- dat[[i]][1:9]
        
        # variable names
        vnms <- names(dat[[i]]$additionalInfo)
        df[i, vnms] <- dat[[i]]$additionalInfo
    }
    
    for (i in 1:ncol(df)) {
        if (is.numeric(df[, i])) 
            df[, i] <- as.numeric(df[, i])
        if (is.integer(df[, i])) 
            df[, i] <- as.integer(df[, i])
    }
    
    
    if (rclass == "tibble") {
        df <- tibble::as_tibble(df)
    }
    
    df
}
