trl2tbl <- function(res, include){
  lst <- jsonlite::fromJSON(res)
  dat <- jsonlite::toJSON(lst$result$data)
  dat <- jsonlite::fromJSON(dat)

  nms <- unique(lapply(dat, names) %>% unlist)
  #TODO vectorize the next
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
  names(df)[9:length(nms)] <- paste0("additionalInfo.", nms[9:length(nms)])
  for(i in 1:length(dat)){
      df[i, 1:7] <- dat[[i]][1:7]
      an <- paste0("additionalInfo.", names(dat[[i]]$additionalInfo))
      if(ncol(dat[[i]]$additionalInfo) > 0) df[i, an] <- dat[[i]]$additionalInfo
  }
  #TODO gather data for studies in separate table and then join; get data of additionalInfo (1st)

  out
}
