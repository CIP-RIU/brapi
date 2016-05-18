.onLoad <- function(libname = find.package("brapi"), pkgname = "brapi") {
  crops <<- c("cassava", "potato", "sweetpotato")

  brapi <<- brapi_con("crop", "http://sample.com", 8080, "rs", "pwd")

  #packageStartupMessage(paste("Hello, BrAPI!", brapi))
}
