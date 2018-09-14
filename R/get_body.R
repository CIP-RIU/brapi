get_body <- function(...) {
  forbidden <- "[/?&]$"

  args <- list(...)
  p <- list()
  j <- 1

  for (i in seq_along(args)) {

    if (!is.null(args[[i]][1])  ) {
      #args[[i]] <- stringr::str_trim(args[[i]])
      if (all(args[[i]] != "")) {
        p[j] <- as.array(args[i])
        names(p)[j] <- names(args)[i]
        j <- j + 1
      }

    }

  }
  #print(p)

  return(p)
}
