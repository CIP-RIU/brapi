show_server_status_messages <- function(out) {

  ba_message(crayon::blue(out$info))
  ba_message(crayon::green(out$success))
  ba_message(crayon::red(out$error))

}
