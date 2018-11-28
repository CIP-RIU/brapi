#' ba_germplasm_pedigree
#'
#' Retrieve germplasm pedigree by internal germplasm database identifier
#'
#' @param con brapi connection object
#' @param germplasmDbId character, the internal database identifier for a
#'                      germplasm of which the germplasm pedigree is to be
#'                      retrieved e.g. "9932"; \strong{REQUIRED ARGUMENT} with
#'                      default: ""
#' @param notation character, text representation of the pedigree e.g. "purdy";
#'                 default: ""
#' @param includeSiblings logical, indicating whether to include, specified as
#'                        TRUE, a siblings array or not, specified as FALSE;
#'                        default: NA
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the germplasm
#'         pedigree.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
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
                                  includeSiblings = NA,
                                  rclass = c("tibble", "data.frame",
                                             "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(germplasmDbId)
  stopifnot(is.logical(includeSiblings))
  check_req(germplasmDbId)
  rclass <- match_req(rclass)

  brp <- get_brapi(con = con) %>% paste0("germplasm/", germplasmDbId, "/pedigree")
  callurl <- get_endpoint(brp,
                          notation = notation,
                          includeSiblings = includeSiblings)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
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
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass == "tibble")
      out <- ms2tbl(res = cont) %>% tibble::as_tibble()
    if (rclass == "data.frame") {
      out <- ms2tbl(res = cont) %>%
             tibble::as_tibble() %>%
             as.data.frame()
    }
    class(out) <- c(class(out), "ba_germplasm_pedigree")
    show_metadata(resp)
    return(out)
  })
}
