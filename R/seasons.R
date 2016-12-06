#' seasons
#'
#' lists the seasons and years
#'
#' @param year integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @param rclass character; one of list (default) or data.frame
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @export
seasons <- function(year = NULL, page = 0, pageSize = 1000, rclass = "list") {
  brapi::check(FALSE)
  if(is.null(page) & is.null(pageSize)) {
    seasons_list = paste0(get_brapi(), "seasons")
  }
  if (is.numeric(page) & is.numeric(pageSize)) {
    seasons_list = paste0(get_brapi(), "seasons?page=", page, "&pageSize=", pageSize)
  }

  if (!is.null(year)) {
    seasons_list = paste0(seasons_list, "&year=", year)
  }


  seasons <- tryCatch({
    res <- httr::GET(seasons_list)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
      ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  if(rclass == "data.frame") {
    dat <- seasons$result$data %>% unlist() %>%
             matrix(ncol = 3, byrow = T) %>% as.data.frame
    names(dat) = c("id", "season", "year")
    dat[, 1] <- as.integer(dat[, 1])
    dat[, 3] <- as.integer(dat[, 3])
    attr(dat, "status") = seasons$metadata$status
    seasons = dat
  }

  seasons
}
