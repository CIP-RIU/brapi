paging <- function(df,  page, pageSize) {
  nn = nrow(df)
  pageTotal = ceiling(nn / pageSize)
  if(page >= pageTotal) page = 0
  recStart = page * pageSize + 1
  recEnd = min((recStart + pageSize - 1), nn)
  list(recStart = recStart, recEnd = recEnd,
       pagination = list(
         currentPage = page,
         pageTotal = pageTotal,
         totalCount = nn,
         pageSize = pageSize
       )
  )
}
