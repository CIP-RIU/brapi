mpa2tbl <- function(res, rclass = "tibble") {
    lst <- jsonlite::fromJSON(res)
    dat <- jsonlite::toJSON(lst$result$data$data)
    dba <- jsonlite::fromJSON(dat)
    udb <- unlist(dba)
    udb <- udb[!is.na(udb)] %>% as.data.frame(stringsAsFactors = FALSE)
    udb <- as.data.frame(cbind(marker = rownames(udb), alleles = udb[, 1]), stringsAsFactors = FALSE)
    if (rclass == "tibble")
        udb <- tibble::as_tibble(udb)
    attr(udb, "metadata") <- as.list(lst$result$data[1:5])

    class(udb) <- c(class(udb), "brapi_markerprofiles_alleles")
    return(udb)
}
