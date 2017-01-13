df2tibble <- function(rclass = "data.frame") {
    if (rclass == "data.frame") {
        message_brapi("A data.frame does not work with vectors. Switching to tibble!")
        rclass <- "tibble"
    }
    rclass
}
