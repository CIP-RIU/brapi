show_pagination <- function(res) {

  res <- jsonlite::fromJSON(txt = res)

  if (is.null(res$metadata)) return()
  pagination <- res$metadata$pagination

  if (!is.null(pagination)) {
    ba_message(msg = paste0("Returning page ",
                            pagination$currentPage,
                            " (max. ",
                            as.integer(pagination$totalPages) - 1,
                            ") with max. ",
                            pagination$pageSize,
                            " items (out of a total of ",
                            pagination$totalCount,
                            ")."))

  }

}
