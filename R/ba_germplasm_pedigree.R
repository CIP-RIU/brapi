#' ba_germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId character; \strong{REQUIRED ARGUMENT} with default ''
#' @param notation character; optional, recommended value: purdue format. Default: ''
#' @param includeSiblings logic; optional, default: TRUE
#' @param rclass character; default: tibble
#'
#' @return list of pedigree data
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/Germplasm_Pedigree_GET.md}{github}
#'
#' @family germplasm
#' @family brapicore
#'
#' @example inst/examples/ex-ba_germplasm_pedigree.R
#'
#' @import httr
#' @export
ba_germplasm_pedigree <- function(con = NULL,
                                  germplasmDbId = "",
                                  notation = "",
                                  includeSiblings = TRUE,
                                  rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId)
  stopifnot(is.logical(includeSiblings))
  check_req(germplasmDbId)
  rclass <- match_req(rclass)

  brp <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/pedigree")
  callurl <- get_endpoint(brp, notation = notation, includeSiblings = includeSiblings)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    ms2tbl <- function(res) {
      lst <- jsonlite::fromJSON(txt = res)
      dat <- jsonlite::toJSON(x = lst$result)
      res3 <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)
      for (i in 1:length(res3)) {
        if (length(res3[[i]]) == 0) res[[i]] <- ''
      }
      # Set null length list-type elements to ''
      for (i in 1:length(res3)) {
        if (length(res3[[i]]) == 0) res3[[i]] <- ""
      }
      if (length(res3$siblings) > 1) {
        siblings <- res3$siblings
        names(siblings) <- paste0('siblings.', names(siblings))
        res3$siblings <- NULL
        res3 <- tibble::as.tibble(res3)
        res3 <- cbind(res3, siblings)
        siblings <- NULL
      }
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
