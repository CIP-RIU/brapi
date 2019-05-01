get_body <- function(...) {
  # forbidden <- "[/?&]$"

  args <- list(...)
  p <- list()
  j <- 1

  for (i in seq_along(args)) {
    if (any(is.null(args[[i]]))) args[[i]] <- ""
    if (any(is.na(args[[i]]))) args[[i]] <- ""

    if (all(args[[i]] != "")) {
      if (class(args[[i]]) == "character" && length(args[[i]]) > 1) {
        p[[j]] <- as.array(args[[i]])
      } else {
        p[[j]] <- args[[i]]
      }
      names(p)[j] <- names(args)[i]
      j <- j + 1
    }
  }
  return(p)
}
