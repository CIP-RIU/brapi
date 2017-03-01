#' ba_germplasmattributes_details
#'
#' attibutes call.
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble; or else: json, list, data.frame.
#' @param germplasmDbId integer; default: 1.
#' @param attributeList integer vector; default: 1.
#' @param page integer; default: 0.
#' @param pageSize integer; default: 10.
#'
#' @return rclass as set by parameter.
#' @example inst/examples/ex-ba_germplasmattributes_details.R
#' @import httr
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/GermplasmAttributeValuesByGermplasmDbId.md}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes_details <- function(con = NULL, germplasmDbId = 1, attributeList = 1, page = 0, pageSize = 10,
    rclass = "tibble") {
    ba_check(con, FALSE)
    brp <- get_brapi(con)
    germplasm_attributes_list <- paste0(brp, "germplasm/", germplasmDbId, "/attributes/?attributeList=",
        paste(attributeList, collapse = ","), "&page=", page, "&pageSize=", pageSize)

    try({
        res <- brapiGET(germplasm_attributes_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")

        ms2tbl <- function(res) {
            attributeDbId <- NULL
            attributeCode <- NULL
            attributeName <- NULL
            value <- NULL
            dateDetermined <- NULL
            res %>% as.character %>% enter_object("result") %>%
              spread_values(germplasmDbId = jnumber("germplasmDbId")) %>%
                enter_object("data") %>% gather_array %>%
              spread_values(attributeDbId = jnumber("attributeDbId"),
                attributeCode = jstring("attributeCode"),
                attributeName = jstring("attributeName"), value = jstring("value"),
                dateDetermined = jstring("dateDetermined")) %>%
              dplyr::select(germplasmDbId, attributeDbId,
                attributeName, attributeCode, value, dateDetermined)
        }

        if (rclass %in% c("json", "list"))
            out <- dat2tbl(res, rclass)
        if (rclass == "data.frame")
            out <- ms2tbl(res)
        if (rclass == "tibble")
            out <- ms2tbl(res) %>% tibble::as_tibble()

        class(out) <- c(class(out), "ba_germplasmattributes_details")
        return(out)
    })
}
