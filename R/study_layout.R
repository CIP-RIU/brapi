#' study layout
#'
#' Gets additional metadata about a study
#'
#' @param studyId integer
#' @import httr
#' @author Reinhard Simon
#' @return list of study attributes
#' @references \url{http://docs.brapi.apiary.io/#reference/study/layout/retrieve-study-details?console=1}
#' @export
study_layout <- function(studyId = NULL) {
  check_id(studyId)

  qry = paste0("studies/", studyId, "/layout?")
  req <- brapi_GET(qry) %>% httr::content()
  pgs = req$metadata$pagination$totalPages %>% as.integer()
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  if (length(dat) == 0) return(NULL)  # No data!
  dat
}
