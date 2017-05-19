df2tibble <- function(rclass = "data.frame") {
  if (rclass == "data.frame") {
    ba_message("A data.frame does not work with vectors. Switching to tibble!")
    rclass <- "tibble"
  }
  return(rclass)
}
