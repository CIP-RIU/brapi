.onAttach <- function(libname, pkgname) {

  txt <- paste(
        "This is the development version of the 'brapi' package!\n
        You are using version ",
        utils::packageVersion("brapi"), "\n\n")
  txt <- paste(
    "Please note that current supports most BrAPI calls of version 1.2
     while moving towards 1.3!\n

     Also, checks on response objects and fields are only loosely implemented to accomodate differences
      between BrAPI versions.
    If you find issues please \n
    - turn on comments with ba_show_info()\n.
    - You can double check against the database by copy/paste of the reported BrAPI URL\n
      at: http://webapps.ipk-gatersleben.de/brapivalidator!\n\n",
    utils::packageVersion("brapi"), "\n\n")
  txt <- paste(txt,
        "Please register any further issues at:
        https://github.com/CIP-RIU/brapi/issues\n")



  packageStartupMessage(txt)
}

.onLoad <- function(libname, pkgname) {

}
