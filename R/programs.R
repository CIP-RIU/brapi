#' programs
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param page integer requested page number, default = 0 (1st page)
#' @param rclass string; default: tibble
#' @param pageSize items per page (default = 100)
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @references \url{http://docs.brapi.apiary.io/#reference/0/program-list/list-programs}
#' @export
programs <- function(page = 0, pageSize = 100, rclass = "tibble") {
  brapi::check(FALSE)
  brp <- get_brapi()
  if(page == 0 & pageSize == 100) {
    programs_list = paste0(brp, "programs")
  } else if (is.numeric(page) & is.numeric(pageSize)) {
    programs_list = paste0(brp, "programs/?page=", page, "&pageSize=", pageSize)
  }


  programs <- tryCatch({
    res <- brapiGET(programs_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    dat2tbl(res, rclass)
  }, error = function(e){
    NULL
  })

  programs
}
