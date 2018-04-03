#' ba_germplasmattributes_details
#'
#' attibutes call.
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble; or else: json, list, data.frame.
#' @param germplasmDbId character; default: 1.
#' @param attributeList character vector; default: 1.
#' @param page integer; default: 0.
#' @param pageSize integer; default: 10.
#'
#' @return rclass as set by parameter.
#' @example inst/examples/ex-ba_germplasmattributes_details.R
#' @import httr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/GermplasmAttributeValuesByGermplasmDbId.md}{github}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes_details <- function(con = NULL,
                                           germplasmDbId = "1",
                                           attributeList = "1",
                                           page = 0,
                                           pageSize = 10,
                                           rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.character(germplasmDbId))
  stopifnot(is.character(attributeList))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the specific brapi call url
  germplasm_attributes_list <- paste0(brp,
                                      "germplasm/",
                                      germplasmDbId,
                                      "/attributes/?attributeList=",
                                      paste(attributeList, collapse = ","),
                                      "&page=",
                                      page,
                                      "&pageSize=",
                                      pageSize)
  try({
    res <- brapiGET(url = germplasm_attributes_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    ms2tbl <- function(res) {
      lst <- tryCatch(
        jsonlite::fromJSON(txt = res)
      )

      assertthat::assert_that("data" %in% names(lst$result),
                  msg = "The json return object lacks a data element.")
      dat <- jsonlite::toJSON(x = lst$result$data)

      df <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE,
                               flatten = TRUE)[[1]]
      assertthat::validate_that(nrow(df) > 0,
                  msg = "The json return object lacks a data element.")

      return(df)
    }
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass == "data.frame") {
      out <- ms2tbl(res = res)
    }
    if (rclass == "tibble") {
      out <- ms2tbl(res = res) %>% tibble::as_tibble()
    }
    class(out) <- c(class(out), "ba_germplasmattributes_details")
    show_metadata(con, res)
    return(out)
  })
}
