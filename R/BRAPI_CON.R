# #' brapi_con
# #'
# #' S3 class constructor. It also places an object named 'brapi' in the parent environment.
# #' This can be used later to refresh credentials using a 'brapi_auth' function call.
# #'
# #' @param crop character string
# #' @param db character string (url)
# #' @param port numeric (optional, default 80)
# #' @param user character string (optional, default '')
# #' @param pwd character string (optional, default '')
# #' @param session character string (optional)
# #'
# #' @return object of class 'brapi'
# #' @family brapi_con
# #' @author Reinahard Simon
# #' @export
# #'
# #' @example inst/examples/brapi_con.R
# brapi_con <- function(crop, db, port = 80, user = "", pwd = "", session="") {
#   .Deprecated("connect")
#   if(!can_internet()) {
#     message("Can not connect to internet!")
#     return(NULL)
#   }
#
#   stopifnot(is.numeric(port))
#   stopifnot(all(is.character(crop),
#                 is.character(db),
#                 is.character(user),
#                 is.character(pwd)),
#                 is.character(session)
#             )
#
#   obj <- list(crop = crop,
#                 db = db,
#               port = port,
#               user = user,
#               pwd  = pwd,
#               session = session)
#   attr(obj, "class") = "brapi_con"
#   brapi <<- obj
#   if(user != "" & pwd != "" ) brapi_auth(user, pwd)
#   obj
# }
#
# #' is.brapi
# #'
# #' check type function
# #'
# #' @param obj object to be tested
# #'
# #' @return boolean
# #' @export
# #' @author Reinahard Simon
# #' @family brapi_con
# #'
# #' @example inst/examples/brapi_con.R
# is.brapi <- function(obj) {
#   class(obj) == "brapi_con"
# }
#
#
# #' print.brapi_con
# #'
# #' print method
# #'
# #' @param x brapi object
# #' @param ... other print parameters
# #' @author Reinahard Simon
# #' @family brapi_con
# #' @export
# #'
# #' @example inst/examples/brapi_con.R
# print.brapi_con <- function(x, ...){
#   cat(paste0(x$crop, ":\n\n"))
#   cat(paste0(x$db, ":", x$port, "\n"))
#   cat(paste0("User: ", x$user, "\n"))
# }


