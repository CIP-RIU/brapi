
#' germplasm search
#'
#' Lists germplasmm as result of a search.
#'
#' @param name string
#' @param matchMethod defaults to 'wildcard'.
#' @param include synonyms of germplasm
#' @param pageSize integer
#' @param page integer
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @references \url{http://docs.brapi.apiary.io/reference/germplasm/germplasm-search/search-names-to-retrieve-germplasm-records}
#'
#' @return data.frame
#' @export
germplasm_search <- function(name = "*", matchMethod = "wildcard", include = "synonyms",
                           pageSize = 10, page = 1){
  get_set <- function(page){
    brapi_GET(paste0("germplasm?name=",name, "&matchMethod=", matchMethod, "&include=",include,
                     "&pageSize=",pageSize,"&page=", page))
  }

  pb <- progress_bar$new(total = 1e7, clear = FALSE, width = 60,
                         format = "  downloading :what [:bar] :percent eta: :eta")
  pb$tick(tokens = list(what = "germplasm list   "))
  gpl = get_set(1)

  req = httr::content(gpl)
  pgs = req$metadata$pagination$totalPages %>% as.integer()
  #print(pgs)
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  n = length(dat)
  get_rdf <- function(n) {
    data.frame(
    germplasmDbId = integer(n),
    germplasmPUI = character(n),
    accessionNumber = character(n),
    germplasmName = character(n),
    synonyms = character(n),
    defaultDisplayName = character(n),
    pedigree = character(n),
    seedSource = character(n)
    , stringsAsFactors = F)
  }
  rdf <- get_rdf(n)
  list2tbl <- function(req,  rdf) {
    # decide how to fill in total table
    n = length(req)

    for(i in 1:n){
      val = req[[i]]$germplasmDbId
      if(!is.null(val)) rdf$germplasmDbId[i] <- val %>% as.integer()
      val = req[[i]]$germplasmPUI
      if(!is.null(val)) rdf$germplasmPUI[i] <- val
      val = req[[i]]$accessionNumber
      if(!is.null(val)) rdf$accessionNumber[i] = val
      val = req[[i]]$germplasmName
      if(!is.null(val)) rdf$germplasmName[i] = val
      val = req[[i]]$defaultDisplayName
      if(!is.null(val)) rdf$DefaultDisplayName[i] = val
      val = req[[i]]$pedigree
      if(!is.null(val)) rdf$pedigree[i] = val
      val = req[[i]]$seedSource
      if(!is.null(val)) rdf$seedSource[i] = val
      val = req[[i]]$synonyms
      if(!is.null(val)) rdf$synonyms[i] = val %>% paste(collapse = "; ")
    }
    rdf
  }
  out=list2tbl(dat, rdf)

  if(pgs > 1) {
    for(p in 2:pgs){
      pb$tick(sample(2:pgs * 1000, 1),
              tokens = list(what = "germplasm list   "))
      #pb$update(p/100, list(what = ""))
      gpl = get_set(p)
      req = httr::content(gpl)
      dat = req$result$data
      n = length(dat)
      dat = list2tbl(dat, get_rdf(n))
      out = rbind(out, dat)
      #print(p)
    }
  }
  pb$tick(1e7,  tokens = list(what = "germplasm list   "))
  out
}

