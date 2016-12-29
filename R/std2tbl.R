std2tbl <- function(res, rclass){
  lst <- jsonlite::fromJSON(res)
  if(length(lst$result) == 0) return(NULL)
  dat <- jsonlite::toJSON(lst$result$data)
  dat <- jsonlite::fromJSON(dat)

  nms <- unique(lapply(dat, names) %>% unlist)

  n = length(dat)
  x = character(n)
  for(i in 1:n){
    x = c(x, names(dat[[i]]$additionalInfo))
  }
  nms <- c(nms, unique(x))
  nms <- nms[!nms %in% c("", "additionalInfo")]

  # construct basic data.frame

  df <- as.data.frame(matrix(NA, ncol = length(nms), nrow = n),
                      stringsAsFactors = FALSE)
  names(df) <- nms
  names(df)[14:length(nms)] <- paste0("additionalInfo.", nms[14:length(nms)])
  for(i in 1:length(dat)){
      df[i, 1:13] <- dat[[i]][1:13]
      an <- paste0("additionalInfo.", names(dat[[i]]$additionalInfo))
      if(ncol(dat[[i]]$additionalInfo) > 0) df[i, an] <- dat[[i]]$additionalInfo
  }
  df$seasons = lapply(df$seasons, paste, collapse = "; ") %>% unlist

  out = df
  if(rclass == "tibble") out = tibble::as_tibble(df)


  out
}
