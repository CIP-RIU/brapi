#' seasons
#'
#' lists the seasons and years
#'
#' @param year integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @param progress logical default is FALSE
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @export
seasons <- function(year = NULL, page = NULL, pageSize = NULL, progress = FALSE) {
  if(progress) {
    pb <- progress_bar$new(total = 1e7, clear = FALSE, width = 60,
                           format = "  downloading :what [:bar] :percent eta: :eta")
    pb$tick(tokens = list(what = "program list   "))
  }

  if(is.null(page) & is.null(pageSize)) {
    seasons_list = paste0(get_brapi(), "seasons")
  }

  if (is.numeric(year)) {
    #seasons_list = paste0(seasons_list, "/?page=", page, "&pageSize=", pageSize)
    #TODO
    httr::modify_url(seasons_list, params =  )
  }


  if (is.numeric(page) & is.numeric(pageSize)) {
    seasons_list = paste0(seasons_list, "&page=", page, "&pageSize=", pageSize)
  }


  programs <- tryCatch({
    res <- httr::GET(programs_list)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
      ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  if (progress) pb$tick(1e7, tokens = list(what = "program list   "))

  programs
}
