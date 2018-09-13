get_body <- function(...) {
  forbidden <- "[/?&]$"

  args <- list(...)
  p <- list()
  j <- 1

  for (i in seq_along(args)) {
    if (!is.null(args[[i]]) && args[[i]] != "") {
      args[[i]] <- sub(forbidden, "", args[[i]])
      p[[j]] <- paste(args[[i]], collapse = ",")
      names(p)[[j]] <- names(args)[[i]]
      j <- j + 1
    }
  }

  return( p)
}
