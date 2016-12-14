safe_split <- function(s, sep = ";"){
  sep = paste0(sep, "[\\s]*")
  if(stringr::str_detect(s, sep) ) {
    s = stringr::str_split(s, sep)[[1]]
  }
  s
}
