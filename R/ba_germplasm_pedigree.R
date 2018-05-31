#' ba_germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId character; default ''
#'
#' @param notation character; optional, recommended value: purdue format. Default: ''
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @return list of pedigree data
#' @example inst/examples/ex-ba_germplasm_pedigree.R
#' @import httr
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmPedigree.md}{github}
#' @family germplasm
#' @family brapicore
#' @export
ba_germplasm_pedigree <- function(con = NULL,
                                  germplasmDbId = "",
                                  notation = "",
                                  rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.character(germplasmDbId))
  stopifnot(germplasmDbId != '')

  check_rclass(rclass = rclass)
  # generate brapi call url
  pnotation <- ifelse(notation != '', paste0("/pedigree/?notation=", notation), "/pedigree")
  germplasm_pedigree <- paste0(get_brapi(con = con), "germplasm/",
                        germplasmDbId, pnotation)
  try({
    res <- brapiGET(url = germplasm_pedigree, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res) {
      lst <- jsonlite::fromJSON(txt = res2)
      dat <- jsonlite::toJSON(x = lst$result)
      res3 <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)
      attr(res3, "metadata") <- lst$metadata
      return(res3)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass == "tibble")
      out <- ms2tbl(res = res2) %>% tibble::as_tibble()
    if (rclass == "data.frame") {
      out <- ms2tbl(res = res2) %>%
             tibble::as_tibble() %>%
             as.data.frame()
    }
    class(out) <- c(class(out), "ba_germplasm_pedigree")
    show_metadata(res)
    return(out)
  })
}
