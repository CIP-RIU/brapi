toTextTable <- function(tbl, format = "csv", allelematrix = TRUE){
  #tbl = t(tbl)
  n = nrow(tbl)
  #rows = character(n)
  fmt = ifelse(format == "tsv", "\t", ",")
  if(allelematrix) rows = paste0(rownames(tbl), fmt)
  if(!allelematrix) rows = character(nrow(tbl))

  for(i in 1:n){
    xx = tbl[i, ] %>% paste(collapse = fmt)
    rows[i] = paste0(rows[i], xx)
  }

  hdr <- colnames(tbl) %>% paste(collapse = fmt)

  bdy <- rows %>% paste(collapse = "\n")

  if(allelematrix) bdy = paste0("markerprofileDbId", fmt, hdr, "\n", bdy, "\n")
  if(!allelematrix) bdy = paste0(hdr, "\n", bdy, "\n")
  bdy
}
