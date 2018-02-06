show_expiration <- function(con) {

  # Just an idea for the future
  # Since expiring time is refreshed with every call displaying it is not

  if ("expires_in" %in% names(con)) {
    tokenExpires <- as.POSIXct(con$expires_in/1000, origin = "1970-01-01")

    ba_message(msg = paste0("Database connection expires: ",
                            tokenExpires))
  }

}
