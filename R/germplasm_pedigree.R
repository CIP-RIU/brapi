
#' germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'

#' @param germplasmDbId integer; default 0
#'
#' @param notation string; default: purdue format
#' @param rclass string; default: tibble
#'
#' @author Reinhard Simon
#' @return list of pedigree data
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-pedigree}
#' @export
germplasm_pedigree <- function(germplasmDbId = 0, notation = "purdue",
                               rclass = "tibble"){
  brapi::check(FALSE)

  germplasm_pedigree = paste0(get_brapi(), "germplasm/", germplasmDbId,
                              "/pedigree/?notation=", notation)

  tryCatch({
    res <- brapiGET(germplasm_pedigree)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res){
      lst <- jsonlite::fromJSON(res)
      dat <- jsonlite::toJSON(lst$result)
      if (rclass == 'data.frame') {
        res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
      }
      if (rclass == 'tibble') {
        res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
        res <- tibble::as_tibble(res)
      }
      attr(res, "metadata") <- lst$metadata
      res
    }
    if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    if (rclass == "tibble")     out  <- ms2tbl(res) %>% tibble::as_tibble()
    out
  }, error = function(e){
    NULL
  })
}
