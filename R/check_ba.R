check_ba <- function(secure = FALSE,
                     protocol = "http://",
                     db = "127.0.0.1",
                     port = 80,
                     apipath = NULL,
                     multicrop = FALSE,
                     crop = "",
                     user = "",
                     password = "",
                     token = "",
                     granttype = "password",
                     clientid = "rbrapi",
                     bms = FALSE) {
  # check function arguments
  if (!is.logical(secure)) {
    stop("The secure argument can only be a logical (TRUE or FALSE) value.")
    }
  if (!(protocol %in% c("http://", "https://"))) {
    stop("The protocol argument can only be 'https://' or 'http://'.")
  }
  if (!is.character(db)) {
    stop("The db argument can only be a character string.")
  }
  if (!is.numeric(port) | port < 1) {
    stop("The port argument can only be an numeric value > 0.")
  }
  if (!xor(is.null(apipath), is.character(apipath))) {
    stop("The apipath argument can only be NULL or a character string.")
  }
  if (!is.character(crop)) {
    stop("The crop argument can only be a character string.")
  }
  if (!is.logical(multicrop))
    stop("The multicrop argument can only be a logical value (TRUE or FALSE).")
  }
  if (!is.character(user)) {
    stop("The user argument can only be a character string.")
  }
  if (!is.character(password)) {
    stop("The password argument can only be a character string.")
  }
  if (!is.character(token)) {
    stop("The token argument can only be a character string.")
  }
  if (!is.character(granttype)) {
    stop("The granttype argument can only be a character string.")
  }
  if (!is.character(clientid)) {
    stop("The clientid argument can only be a character string.")
  }
  if (!is.logical(bms)) {
    stop("The bms argument argument can only be a logical value (TRUE or FALSE).")
  }
  return(invisible(TRUE))
}
