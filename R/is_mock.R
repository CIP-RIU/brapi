is_mock <- function(con){
  #brapi::check(FALSE)
  ifelse(con$db == "127.0.0.1" & con$port == 2021, TRUE, FALSE)
}
