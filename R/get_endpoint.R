get_endpoint <- function(pointbase, ...) {
  forbidden <- "[/?&]$"
  pointbase <- sub(forbidden, "", pointbase)
  args <- list(...)

  if (all(c("pageSize", "page") %in% names(args))) {
    check_paging(args$pageSize, args$page)
  }
  if ("pageSize" %in% names(args)) {
    args$pageSize <- ifelse(args$pageSize == 1000, "", args$pageSize)
  }
  if ("page" %in% names(args)) {
    args$page <- ifelse(args$page == 0, "", args$page)
  }

  p <- list()
  j <- 1

  for (i in seq_along(args)) {
    if (nchar(names(args)[[i]]) == 0) stop("All parameters must have a name.")
    if (is.logical(args[[i]])) args[[i]] <- tolower(args[[i]])
    if (length(args[[i]]) == 1) {
      if (is.na(args[[i]])) args[[i]] <- ""

      if (args[[i]] == "any") next()
      if (args[[i]] == 0) next()
    }

    if (!is.null(args[[i]]) && args[[i]] != "") {
      args[[i]] <- sub(forbidden, "", args[[i]])

      p[[j]] <- paste0(names(args)[[i]], "=", paste(args[[i]], collapse = ","))
      j <- j + 1
    }
  }
  url <- gsub(pattern = " ",
              replacement = "%20",
              x = paste0(pointbase, "?", paste(p, collapse = "&")))
  return(sub(pattern = forbidden,
             replacement = "",
             x = url))
}
