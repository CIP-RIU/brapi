.onAttach <- function(libname, pkgname) {
  paste("This is the development version of the 'brapi' package!\nYou are using version ", packageVersion("brapi"), "\n\n") %>%
    paste("Please register any issues at: https://github.com/c5sire/brapi/issues\n") %>%
  packageStartupMessage()
}

.onLoad <- function(libname, pkgname) {

}
