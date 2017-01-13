#' locations
#'
#' lists locations available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param locationType string, list of data types
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}(github)
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
# @family phenotyping
#' @export
locations <- function(con = NULL, locationType = "all", page = 0, pageSize = 1000000, rclass = "tibble") {
  brapi::check(con, FALSE, "locations")
  brp <- get_brapi(con)
  locations_list <- paste0(brp, "locations/?")

  plocationType <- ifelse(locationType != "all", paste0("locationType=", locationType, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  if(pageSize == 1000000){
    ppage <- ""
    ppageSize <- ""
  }

  locations_list <- paste0(locations_list, plocationType, ppageSize, ppage )


  try({
    res <- brapiGET(locations_list, con = con)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      #if(con$bms) {
        out <- jsonlite::fromJSON(res, simplifyDataFrame = TRUE)#, flatten = TRUE)
        out <- out$result
        nms <- lapply(out, names) %>% unlist %>% unique()
        nms <- nms[1:9]
        n = length(out)

        df <- as.data.frame(matrix(NA, ncol = length(nms), nrow = n),
                            stringsAsFactors = FALSE)
        names(df) <- nms
        dat = out

        # fill in data in sparse matrix
        for(i in 1:n) {
          #fixed names
          fnms <- names(dat[[i]])[-10] # exclude field additionalInfo
          df[i, fnms] <- dat[[i]][1:9]

          # variable names
          # vnms <- names(dat[[i]]$additionalInfo)
          # df[i, vnms] <- dat[[i]]$additionalInfo
        }
        out = df


        if(rclass == "tibble") out <- tibble::as_tibble(out)
      # } else {
      #   out <- loc2tbl(res, rclass)
      # }

    }
    if(!is.null(out)) class(out) <- c(class(out), "brapi_locations")
    out
  })
}
