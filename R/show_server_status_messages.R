show_server_status_messages <- function(out) {


  show_message <- function(msg_type, msg_Title, msg_color) {
    ba_message(msg_color(paste0("\n", msg_Title,":")))
    sapply(out[names(out) == msg_type] %>% unlist, msg_color) %>%
      as.character %>%
      paste0("\n") %>%
      ba_message()
  }

  if(getOption("brapi_info", default = FALSE) == FALSE) {
    out <- out$metadata$status %>% unlist %>% as.list()
    ba_message(crayon::yellow("Status details from Server:"))

    show_message("info", "Infos", crayon::blue)
    show_message("success", "Successes", crayon::green)
    show_message("error", "Errors", crayon::red)
  }

}
