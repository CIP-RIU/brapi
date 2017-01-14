is_mock <- function(con) {
    ifelse(con$db == "127.0.0.1" & con$port == 2021, TRUE, FALSE)
}
