toTextTable <- function(tbl, format = "csv"){
  #tbl = t(tbl)
  n = nrow(tbl)
  #rows = character(n)
  fmt = ifelse(format == "tsv", "\t", ",")
  rows = paste(rownames(tbl), fmt)
  for(i in 1:n){
    xx = tbl[i, ] %>% paste(collapse = fmt)
    rows[i] = paste0(rows[i], xx)
  }

  hdr <- colnames(tbl) %>% paste(collapse = fmt)
  bdy <- rows %>% paste(collapse = "\n")

  paste0("markerprofileDbIds", fmt, hdr, "\n", bdy, "\n")
}
