.onAttach <- function(libname, pkgname) {

  txt <- paste("This is the development version of the 'brapi' package!\nYou are using version ",
        utils::packageVersion("brapi"), "\n\n")
  txt <- paste(txt, "Please register any issues at: https://github.com/c5sire/brapi/issues\n")
  packageStartupMessage(txt)
}

.onLoad <- function(libname, pkgname) {

}
