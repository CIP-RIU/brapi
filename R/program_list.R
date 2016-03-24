#' program list
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param page integer requested page number
#' @param pageSize items per page
#' @import httr
#' @import magrittr
#' @author Reinhard Simon
#' @return data.frame
#' @export
program_list <- function(pageSize = 20, page = 1) {
  # get_set <- function(page){
  #   brapi_GET(paste0("programs?",
  #                    "pageSize=",pageSize,"&page=", page))
  # }
  #
  pb <- progress_bar$new(total = 1e7, clear = FALSE, width = 60,
                         format = "  downloading :what [:bar] :percent eta: :eta")
  pb_what = "program list   "
  pb$tick(tokens = list(what = pb_what))
  # gpl = get_set(1)

  qry = paste0("programs?")
  req <- get_page(qry, page = page, pageSize = pageSize)

  #req = httr::content(gpl)
  pgs = req$metadata$pagination$totalPages %>% as.integer()
  #print(pgs)
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  if (is.null(dat)) return(NULL)  # No data!

  #print(dat)
  n = length(dat)
  get_rdf <- function(n) {
    data.frame(
      programDbId = integer(n),
      name = character(n),
      objective= character(n),
      leadPerson = character(n)
      , stringsAsFactors = F)
  }
  rdf <- get_rdf(n)
  list2tbl <- function(data,  rdf) {
    # decide how to fill in total table
    n = length(data)
    #print(n)
    for(i in 1:n){
      #print(paste(":", i))
      dat = data[[i]]
       # flatten response data to simple list
      cn = names(dat)
      m = length(cn)
      for(j in 1:m){
        ct = typeof(rdf[, cn[j]])
        rdf[i, cn[j]] <- assign_item(cn[j], dat, ct)
      }
    }
    rdf
  }
  out=list2tbl(req$result$data, rdf)

  if(pgs > 1) {
    for(p in 2:pgs){
      pb$tick(sample(2:pgs * 1000, 1),
              tokens = list(what = pb_what))
      #pb$update(p/100, list(what = ""))
      req = get_page(qry, page = p, pageSize = pageSize)
      dat = req$result$data
      n = length(dat)
      dat = list2tbl(dat, get_rdf(n))
      out = rbind(out, dat)
      #print(p)
    }
  }
  pb$tick(1e7,  tokens = list(what = pb_what))



  out[1:n, ] # fixing a bug in sweetpotato BRAPI: only the 1st unique ids


}
