toTextTable <- function(tbl, format = "csv"){
  n = nrow(tbl)
  rows = character(n)
  fmt = ifelse(format == "tsv", "\t", ",")
  for(i in 1:n){
    rows[i] = tbl[i, ] %>% paste(collapse = fmt)
  }
  hdr <- colnames(tbl) %>% paste(collapse = fmt)
  bdy <- rows %>% paste(collapse = "\n")
  paste0(hdr, "\n", bdy, "\n")
}
