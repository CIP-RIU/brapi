stdd2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    if (length(lst$result) == 0) 
        return(NULL)
    dat <- jsonlite::toJSON(lst$result)
    dat <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
    # dat = as.data.frame(dat)
    
    if (length(dat$contacts[[1]]) != 0) {
        contacts = cbind(studyDbId = rep(dat$studyDbId, nrow(dat$contacts)), dat$contacts)
        dat$contacts <- NULL
        dat = as.data.frame(dat)
        dat = merge(dat, contacts)
    } else {
        dat$contacts <- NULL
        dat <- as.data.frame(dat)
    }
    
    
    if (rclass == "tibble") 
        dat = tibble::as_tibble(dat)
    dat
}
