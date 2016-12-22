# #' study details
# #'
# #' Gets additional metadata about a study
# #'
# #' @param studyId integer
# #' @import httr
# #' @importFrom magrittr '%>%'
# #' @author Reinhard Simon
# #' @return list of study attributes
# #' @references \url{http://docs.brapi.apiary.io/#reference/study/study-details/retrieve-study-details?console=1}
# # @export
# study_details <- function(studyId = NULL) {
#   check_id(studyId)
#
#   qry = paste0("studies/", studyId, "/details?")
#   req <- brapi_GET(qry) %>% httr::content()
#   pgs = req$metadata$pagination$totalPages %>% as.integer()
#   if(length(pgs)==0) stop('Session expired!')
#   dat = req$result
#   if (is.null(dat)) return(NULL)  # No data!
#   dat
# }
