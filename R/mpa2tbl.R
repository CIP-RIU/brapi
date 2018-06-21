mpa2tbl <- function(res, rclass = "tibble") {
  lst <- jsonlite::fromJSON(txt = res)
  dat <- jsonlite::toJSON(x = lst$result$data)
  dba <- jsonlite::fromJSON(txt = dat)
  udb <- unlist(dba)
  udb <- udb[!is.na(udb)] %>% as.data.frame(stringsAsFactors = FALSE)
  if (nrow(udb) > 0) {
    udb <- as.data.frame(x = cbind(marker = rownames(udb), alleles = udb[, 1]),
                         stringsAsFactors = FALSE)

  }
  if (rclass == "tibble") {
    udb <- tibble::as_tibble(udb)
  }
  attr(udb, "metadata") <- as.list(lst$result$data[1:5])
  class(udb) <- c(class(udb), "ba_markerprofiles_alleles")
  return(udb)
}
