std2tbl <- function(res, rclass) {
    lst <- jsonlite::fromJSON(res)
    if (length(lst$result) == 0)
        return(NULL)
    dat <- jsonlite::toJSON(lst$result$data)
    dat <- jsonlite::fromJSON(dat)

    x <- dat$additionalInfo
    colnames(x) <- paste0("additionalInfo.", colnames(x))
    dat$additionalInfo <- NULL
    dat <- cbind(dat, x)
    dat$seasons <- lapply(dat$seasons, paste, collapse = "; ") %>% unlist
    out <- dat
    if (rclass == "tibble")
        out <- tibble::as_tibble(dat)
    out
}
