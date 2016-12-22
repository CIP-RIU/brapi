# #' study instances
# #'
# #' Gets list of study instances for a study
# #'
# #' @param studyId integer
# #' @param page integer requested page number
# #' @param pageSize items per page
# #' @import httr
# #' @importFrom magrittr '%>%'
# #' @author Reinhard Simon
# #' @return list of marker profile ids
# #' @references \url{http://docs.brapi.apiary.io/#reference/study/list-studies/list-of-study-summaries?console=1}
# #' @export
# study_instances <- function(studyId = NULL, page = 1, pageSize = 100) {
#   check_id(studyId)
#   check_id(page)
#   check_id(pageSize)
#
#   pb <- progress_bar$new(total = 1e7, clear = FALSE, width = 60,
#                          format = "  downloading :what [:bar] :percent eta: :eta")
#   pb_what = "study instances   "
#   pb$tick(tokens = list(what = pb_what))
#   qry = paste0("studies/", studyId, "/instances?")
#
#   req <- get_page(qry, page = page, pageSize = pageSize)
#   pgs = req$metadata$pagination$totalPages %>% as.integer()
#   if(length(pgs)==0) stop('Session expired!')
#   dat = req$result$data
#   if (is.null(dat)) return(NULL)  # No data!
#   n = length(dat)
#   get_rdf <- function(n) {
#     data.frame(
#       instanceNumber = integer(n),
#       locationName =character(n)
#       , stringsAsFactors = F)
#   }
#
#   rdf <- get_rdf(n)
#
#
#   list2tbl <- function(data,  rdf) {
#     # decide how to fill in total table
#     n = length(data)
#
#     for(i in 1:n){
#       dat = data[[i]]
#       m = length(dat)
#       # flatten response data to simple list
#       cn = names(dat)
#       for(j in 1:m){
#         ct = typeof(rdf[, cn[j]])
#         rdf[i, cn[j]] <- assign_item(cn[j], dat, ct)
#       }
#     }
#     rdf
#   }
#   out=list2tbl(req$result$data, rdf)
#
#   if(pgs > 1) {
#     for(p in 2:pgs){
#       pb$tick(sample(2:pgs * 1000, 1),
#               tokens = list(what = pb_what))
#       #pb$update(p/100, list(what = ""))
#       req = get_page(qry, page = p, pageSize = pageSize)
#       data = req$result$data
#       n = length(data)
#       dat = list2tbl(data, get_rdf(n))
#       out = rbind(out, dat)
#       #print(p)
#     }
#   }
#   pb$tick(1e7,  tokens = list(what = pb_what))
#   out
# }
