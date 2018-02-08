show_pagination <- function(res) {
  pagination <- jsonlite::fromJSON(txt = res,
                                   simplifyVector = FALSE)$metadata$pagination

  ba_message(msg = paste0("Returning page ",
                          pagination$currentPage,
                          " (max. ",
                          pagination$totalPages - 1,
                          ") with max. ",
                          pagination$pageSize,
                          " items (out of a total of ",
                          pagination$totalCount,
                          ")."))

}
