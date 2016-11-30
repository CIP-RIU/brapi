#' programs
#'
#' lists the breeding programs
#'
#' BRAPI discussion: Should this return also the crop?
#'
#' @param page integer requested page number
#' @param pageSize items per page
#' @param progress logical default is FALSE
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @export
programs <- function(page = NULL, pageSize = NULL, progress = FALSE) {
  if(progress) {
    pb <- progress_bar$new(total = 1e7, clear = FALSE, width = 60,
                           format = "  downloading :what [:bar] :percent eta: :eta")
    pb$tick(tokens = list(what = "program list   "))
  }

  if(is.null(page) & is.null(pageSize)) {
    programs_list = paste0(get_brapi(), "programs")
  } else if (is.numeric(page) & is.numeric(pageSize)) {
    programs_list = paste0(get_brapi(), "programs/?page=", page, "&pageSize=", pageSize)
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
