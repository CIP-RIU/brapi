is_mock <- function(){
  brapi::check(FALSE)
  if(brapi$db == "127.0.0.1" & brapi$port == 2021) return(TRUE)
  FALSE
}
