.onAttach <- function(libname, pkgname) {

  txt <- paste(
        "This is the development version of the 'brapi' package!\n
        You are using version ",
        utils::packageVersion("brapi"), "\n\n")
  txt <- paste(txt,
        "Please register any issues at:
        https://github.com/CIP-RIU/brapi/issues\n")
  packageStartupMessage(txt)
}

.onLoad <- function(libname, pkgname) {

}
