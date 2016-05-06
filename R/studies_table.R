#' studies table
#'
#' Gets a simple fieldbook book view back in form of a table
#'
#' The meta attribute has information on year, studyDbId, studyName, locationDbId, list of unique germplasm names, plotNames
#' variable names.
#'
#' @param studyId integer
#' @import httr
#' @importFrom magrittr '%>%'
#' @author Reinhard Simon
#' @return fieldbook with attributes
# @references \url{http://docs.brapi.apiary.io/#reference/study/plot/retrieve-plot-details?console=1}
#' @export
study_table <- function(studyId = NULL) {
  check_id(studyId)

    qry = paste0("studies/", studyId, "/table?pageSize=10000")
  req <- brapi_GET(qry) %>% httr::content()
  pgs = req$metadata$pagination$totalPages %>% as.integer()
  if(length(pgs)==0) stop('Session expired!')
  dat = req$result$data
  if (length(dat) == 0) return(NULL)  # No data!

  ## return a minimal fieldbook table
  dat <- req$result$data
  n = length(dat)
  tbl = data.frame(matrix(unlist(dat), nrow = n, byrow = T)) # %>% data.table::as.data.table()
  nms = stringr::str_split(req$result$observationVariableName, "\\|") %>% unlist
  nms <- nms[!stringr::str_detect(nms,"CO_")]
  names(tbl) <- nms

  #get original plot id, rep, block
  tbl$plotName <- as.character(tbl$plotName)

  plotName2id <- function(s, type="block"){
    stringr::str_extract(tbl$plotName, paste0("_",type,":([0-9]{1,9})_")) %>% stringr::str_replace_all("_","") %>%
      stringr::str_replace(paste0(type, ":"), "") %>% as.integer
  }

  rps <-plotName2id(tbl$plotName, "replicate")
  blk <-plotName2id(tbl$plotName, "block")
  plt <-plotName2id(tbl$plotName, "plot")

  meta = list(
    year = unique(tbl$year) %>% as.character %>% as.integer(),
    studyDbId = unique(tbl$studyDbId) %>% as.character %>%  as.integer(),
    studyName = unique(tbl$studyName) %>% as.character,
    locationDbId = unique(tbl$locationDbId) %>% as.character %>% as.integer(),
    locationName = unique(tbl$locationName) %>% as.character,
    germplasmName = tbl$germplasmName %>% as.character %>% unique %>% sort,
    plotName = tbl$plotName %>% as.character,
    observationVariableName <- req$result$observationVariableName %>% as.character
    )

  tbl$plotName = plt
  tbl$blockNumber = blk
  tbl$rep = rps
  names(tbl)[9:11] = c("PLOT", "REP", "BLOCK")
  tbl = tbl[, c(9, 8, 11, 10, 6, 7, 12:ncol(tbl))]

  tbl$germplasmDbId = tbl$germplasmDbId %>% as.character %>%  as.integer
  #TODO determine idx dynamically somehow from column meaning; e.g. containing 'measuring, computing, ...'
  idx = 7
  for(i in idx:ncol(tbl)){
    nm = names(tbl)[i]
    nu = any(stringr::str_detect(nm, "measuring"), stringr::str_detect(nm, "computing"))
    ig = stringr::str_detect(nm, "counting")
    if(nu) tbl[, i] <- tbl[, i] %>% as.character %>%  as.numeric
    if(ig) tbl[, i] <- tbl[, i] %>% as.character %>%  as.integer
  }

  tbl = tbl[with(tbl, order(PLOT)), ]

  attr(tbl, "meta") = meta

  tbl
}
