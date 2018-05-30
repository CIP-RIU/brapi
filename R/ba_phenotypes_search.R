#' ba_phenotypes_search
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi list, connection object
#' @param germplasmDbIds  vector of character; default: ''
#' @param observationVariableDbIds  vector of character; default: ''
#' @param studyDbIds  vector of character; default: ''
#' @param locationDbIds  vector of character; default: ''
#' @param programDbIds  vector of character; default: ''
#' @param seasonDbIds  vector of character; default: ''
#' @param observationLevel  vector of character; default: ''
#' @param pageSize integer default: 100
#' @param page integer default: 0
#' @param rclass character; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_phenotypes_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Phenotypes/PhenotypeSearch.md}{github}
#' @family brapicore
#' @export
ba_phenotypes_search <- function(con = NULL,
                                 germplasmDbIds = "",
                                 observationVariableDbIds = "",
                                 studyDbIds = "",
                                 locationDbIds = "",
                                 programDbIds = "",
                                 seasonDbIds = "",
                                 observationLevel = "",
                                 pageSize = 100,
                                 page = 0,
                                 rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "phenotypes-search")
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(studyDbIds))
  stopifnot(is.character(locationDbIds))
  stopifnot(is.character(programDbIds))
  stopifnot(is.character(seasonDbIds))
  stopifnot(is.character(observationLevel))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pvariables <- paste0(brp, "phenotypes-search/")
  try({
    body <- list(germplasmDbIds = germplasmDbIds,
                 observationVariableDbIds = observationVariableDbIds,
                 studyDbIds = studyDbIds,
                 locationDbIds = locationDbIds,
                 programDbIds = programDbIds,
                 seasonDbIds = seasonDbIds,
                 observationLevel = observationLevel,
                 pageSize = pageSize,
                 page = page)
    res <- brapiPOST(url = pvariables, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- jsonlite::fromJSON(txt = res2, simplifyDataFrame = TRUE)
      out1 <- out$result$data
      n <- nrow(out1)
      nr <- sapply(X = out1$observations, FUN = nrow)
      nid <- rep.int(x = out1$observationUnitDbId, times = nr)
      out2 <- out1$observations[[1]]
      if (n > 1) {
          for (i in 2:n) {
            out2 <- rbind(out2, out1$observations[[i]])
          }
      }
      out2 <- cbind(observationUnitDbId = nid, out2)
      names(out2)[2:ncol(out2)] <- paste0("observations.",
                                          names(out2)[2:ncol(out2)])
      out3 <- merge(x = out1, y = out2, by = "observationUnitDbId")
      out3$observations <- NULL
      out <- out3
      trt <- as.data.frame(x = cbind(treatments.factor = rep("",
                              nrow(out)),
                              treatments.modality = rep("", nrow(out))),
                           stringsAsFactors = FALSE)
      for (i in 1:nrow(out)) {
          if (length(out$treatments[[i]]) == 2) {
            trt[i, ] <- out$treatments[[i]]
          }
      }
      trt[, 1] <- as.factor(trt[, 1])
      trt[, 2] <- as.factor(trt[, 2])
      out$treatments <- NULL
      out <- cbind(out, trt)
      out <- out[, c(1:19, 27, 28, 20:26)]
      if (rclass == "data.frame") {
        out <- tibble::as_data_frame(x = out)
      } else {
        out <- tibble::as_tibble(x = out)
      }
    }
    class(out) <- c(class(out), "ba_phenotypes_search")
    show_metadata(res)
    return(out)
  })
}
