show_server_status_messages <- function(out) {

  ba_message(crayon::yellow("Status details from Server:"))

  if(all(out$info == "", out$success == "", out$error =="")) {
    ba_message(crayon::yellow("None."))
  } else {

    if (out$info != "") {
      ba_message(crayon::blue("\nInfos"))
      ba_message(crayon::blue(out$info))
    }
    if (out$success != "") {
      ba_message(crayon::green("\nSuccesses:"))
      ba_message(crayon::green(out$success))
    }
    if (out$error != "") {
      ba_message(crayon::red("\nErrors:"))
      ba_message(crayon::red(out$error))
    }

  }

}
