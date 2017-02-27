#' germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'
#' @param con brapi connection object
#' @param germplasmDbId integer; default 0
#'
#' @param notation string; default: purdue format
#' @param rclass string; default: tibble
#'
#' @author Reinhard Simon
#' @return list of pedigree data
#' @import httr
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmPedigree.md}(github)
#' @family germplasm
#' @family brapicore
#' @export
germplasm_pedigree <- function(con = NULL, germplasmDbId = 0, notation = "purdue", rclass = "tibble") {
    brapi::check(con, FALSE)

    germplasm_pedigree <- paste0(get_brapi(con), "germplasm/", germplasmDbId, "/pedigree/?notation=", notation)

    try({
        res <- brapiGET(germplasm_pedigree, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        ms2tbl <- function(res) {
            lst <- jsonlite::fromJSON(res)
            dat <- jsonlite::toJSON(lst$result)
            res <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)
            attr(res, "metadata") <- lst$metadata
            res
        }
        if (rclass %in% c("json", "list"))
            out <- dat2tbl(res, rclass)
        if (rclass == "tibble")
            out <- ms2tbl(res) %>% tibble::as_tibble()
        if (rclass == "data.frame")
            out <- ms2tbl(res) %>% tibble::as_tibble() %>% as.data.frame()
        class(out) <- c(class(out), "brapi_germplasm_pedigree")
        return(out)
    })
}
