#' studies
#'
#' Gets list of studies in a breeding program
#'
#' @param programId integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @import httr
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @import progress
#' @references \url{http://docs.brapi.apiary.io/#reference/study/list-studies/list-of-study-summaries?console=1}
#' @export
studies <- function(programId = NULL, page = 1, pageSize = 10000) {
  #check_id(programId)
  if (is.null(programId) ) {
    programId = ""
  }
  check_id(page)
  check_id(pageSize)

  pb <- progress::progress_bar$new(total = 1e7, clear = FALSE, width = 60,
                         format = "  downloading :what [:bar] :percent eta: :eta")
  pb_what = "studies   "
  pb$tick(tokens = list(what = pb_what))
  if(programId==""){
    #page = NULL
    #pageSize=NULL
    #print("X\n")
    qry = paste0("studies-search?", "&page=", page, "&pageSize=", pageSize)
    #req <- get_page(qry, page = page, pageSize = pageSize)
    #rsp <- brapi_GET(paste0(query))
    url = paste0("https://", get_brapi(), qry)
    rsp <- httr::GET(url)
    req <- httr::content(rsp)

  } else {
    qry = paste0("studies-search?programId=", programId)
    req <- get_page(qry, page = page, pageSize = pageSize)
    # print("y\n")
    # print(qry)
    # print(req)
  }
  #print(req)

  pgs = req$metadata$pagination$totalPages %>% as.integer()
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  if (is.null(dat)) return(NULL)  # No data!

  n = length(dat)
  #print(n)

  get_rdf <- function(n) {
    data.frame(
      studyDbId = integer(n),
      studyPUI = character(n),
      name =character(n),
      studyType = character(n),
      seasons = character(n),
      locationDbId = integer(n),
      locationName = character(n),
      programDbId = integer(n),
      programName = character(n),
      trialDbId = integer(n),
      trialName = character(n),
      startDate = character(n),
      endDate = character(n)
      , stringsAsFactors = F)
  }

  rdf <- get_rdf(n)


  list2tbl <- function(dats,  rdf) {
    # decide how to fill in total table
    n = length(dats)

    for(i in 1:n){
      dat = dats[[i]]
      # oi = dat$additionalInfo
      # dat$additionalInfo = NULL
      # dat = c(dat, list(startDate = oi$startDate))
      # dat = c(dat, list(endDate = oi$endDate))
      # dat = c(dat, list(studyPUI = oi$studyPUI))
      # dat$years = paste(dat$years, collapse = "; ")
      # m = length(dat)
      # # flatten response data to simple list
      # cn = names(dat)
      # for(j in 1:m){
      #   ct = typeof(rdf[, cn[j]])
      #   rdf[i, cn[j]] <- assign_item(cn[j], dat, ct)
      # }
      rdf[i, "studyDbId"] = dat$studyDbId
      rdf[i, "studyPUI"] = dat$additionalInfo$studyPUI
      rdf[i, "seasons"] = dat$seasons
      rdf[i, "programDbId"] = dat$programDbId
      rdf[i, "programName"] = dat$programName
      rdf[i, "name"] = dat$name
      rdf[i, "locationDbId"] = dat$locationDbId
      rdf[i, "studyType"] = dat$studyType
      rdf[i, "trialDbId"] = dat$trialDbId
      rdf[i, "trialName"] = dat$trialName
      rdf[i, "startDate"] = dat$startDate
      rdf[i, "endDate"] = dat$endDate
    }
    rdf
  }
  out=list2tbl(req$result$data, rdf)
  #print(pgs)


  #TODO revise parameters when no programID
  # if(pgs > 1) {
  #   for(p in 2:pgs){
  #     pb$tick(sample(2:pgs * 1000, 1),
  #             tokens = list(what = pb_what))
  #     #pb$update(p/100, list(what = ""))
  #     req = get_page(qry, page = p, pageSize = pageSize)
  #     data = req$result$data
  #     n = length(data)
  #     dat = list2tbl(data, get_rdf(n))
  #     out = rbind(out, dat)
  #     #print(p)
  #   }
  # }
  pb$tick(1e7,  tokens = list(what = pb_what))
  out = tibble::as_tibble(out)
  attr(out, "source") = url

  class(out) = c("brapi", class(out))
  out
}
