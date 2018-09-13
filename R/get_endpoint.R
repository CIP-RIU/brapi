get_endpoint <- function(pointbase, ...) {
  forbidden <- "[/?&]$"
  pointbase <- sub(forbidden, "", pointbase)
  args <- list(...)

  if (all(c("pageSize", "page") %in% names(args))) {
    check_paging(args$pageSize, args$page)
  }

  p <- list()
  j <- 1

  for (i in seq_along(args)) {
    if (nchar(names(args)[[i]]) == 0) stop("All parameters must have a name.")
    if (is.logical(args[[i]])) args[[i]] <- tolower(args[[i]])
    if (!is.null(args[[i]]) && args[[i]] != "") {
      args[[i]] <- sub(forbidden, "", args[[i]])

      p[[j]] <- paste0(names(args)[[i]], "=", paste(args[[i]], collapse = ","))
      j <- j + 1
    }
  }
  url <- paste0(pointbase, "?", paste(p, collapse = "&"))
  return( sub("[/?&]$", "", url) )
}
#
#
# get_endpoint("demo?/&", x = "try?", y = 1, z = 1:5) %>% print
# get_endpoint("demo") %>% print
