#' study plot
#'
#' Gets metadata about a study plot
#'
#' @param studyId integer
#' @param observationVariableId integer
#' @import httr
#' @author Reinhard Simon
#' @return list of study attributes
#' @references \url{http://docs.brapi.apiary.io/#reference/study/plot/retrieve-plot-details?console=1}
#' @export
study_plot <- function(studyId = NULL, observationVariableId=NULL) {
  check_id(studyId)
  check_id(observationVariableId)

  qry = paste0("studies/", studyId, "/observationVariable/", observationVariableId, "?")
  req <- brapi_GET(qry) %>% httr::content()
  pgs = req$metadata$pagination$totalPages %>% as.integer()
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  if (length(dat) == 0) return(NULL)  # No data!
  dat
}
