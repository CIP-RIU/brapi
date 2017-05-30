std2tbl <- function(res, rclass) {
  lst <- jsonlite::fromJSON(txt = res)
  if (length(lst$result) == 0) {
    return(NULL)
  }
  dat <- jsonlite::toJSON(x = lst$result$data)
  dat <- jsonlite::fromJSON(txt = dat)
  x <- dat$additionalInfo
  colnames(x) <- paste0("additionalInfo.", colnames(x))
  dat$additionalInfo <- NULL
  dat <- cbind(dat, x)
  dat$seasons <- lapply(X = dat$seasons, FUN = paste, collapse = "; ") %>% unlist
  out <- dat
  if (rclass == "tibble")
      out <- tibble::as_tibble(x = dat)
  return(out)
}
