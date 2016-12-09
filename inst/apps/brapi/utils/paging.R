paging <- function(df,  page, pageSize) {
  nn = nrow(df)
  #if(page > 0 & pageSize > 0 & pageSize > page) {
    pageTotal = ceiling(nn / pageSize)
    if(page >= pageTotal) page = 0
    recStart = page * pageSize + 1
    recEnd = min((recStart + pageSize - 1), nn)
    list(status = 200,
         recStart = recStart, recEnd = recEnd,
         pagination = list(
           currentPage = page,
           pageTotal = pageTotal,
           totalCount = nn,
           pageSize = pageSize
         )
    )


}
