safe_split <- function(s, sep = ";"){
  if(stringr::str_detect(s, sep) ) {
    s = stringr::str_split(s, sep)[[1]]
  }
  s
}
