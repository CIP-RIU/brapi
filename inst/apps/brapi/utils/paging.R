paging <- function(nn,  page, pageSize) {
  pageTotal = ceiling(nn / pageSize)
  if(page >= pageTotal) page = 0
  recStart = page * pageSize + 1
  recEnd = min((recStart + pageSize - 1), nn)
  list(recStart = recStart, recEnd = recEnd,
       page = page, pageTotal = pageTotal)
}
