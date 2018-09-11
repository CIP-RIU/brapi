get_ppages <- function(pageSize, page) {
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  } else {
    check_paging(pageSize = pageSize, page = page)
    ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                     pageSize, "&"), "")
    ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  }
  return(
    list(pageSize = ppageSize, page = ppage)
  )
}
