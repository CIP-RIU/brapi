is_mock <- function(con) {
   res <- ifelse(con$db == "127.0.0.1" & con$port == 2021, TRUE, FALSE)
   return(res)
}
