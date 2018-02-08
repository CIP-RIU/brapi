# brapi 0.9.9036

- Removed tidyjson
- Removed references to brapiTS mock server
- Removed apidocs folder
- Moved main repo to CIP-RIU
- Adding new tests based on real databases


# brapi 0.0.9.9016 2017-09-17

- Fixed some bugs in trial and germplasm calls
- Re-actived display of server messages and improved display
- Updated tutorial with examples from sweetpotatobase


# brapi 0.0.9.9015 

## NEW Sandbox testing server

To eaes local testing the package has was a companion package with a localized simple testing server implementing the BrAPI v1 protocol. Since Feb 2018 it is discontinued.


The server must be started in a R session separate from the one use for the BrAPI calls.
The server uses by default the port 2021. This can be changed by using the port parameter: brapi::mock_server(80).

**This server was discontinued.** 



# Optionally: authenticate yourself

con = ba_connect(user = "user", password = "password") %>% ba_login()

ba_crops(con) # which crops are available

ba_calls(con) # which calls are available


```


# NEW: Testing the calls

BrAPI calls are now being extensively tested using the testthat framework. The local tests are being executed against the local mock_server instance. If not present a warning message will be displayed.

Quick start in RStudio: Ctrl + Shift + T

# NEW: return tables

- all R functions using the brapi have a new parameter: rclass which can have up to five different values: json, list, data.frame, tibble, vector. The default value is tibble for most functions - that is it will alwways return a table. Vector is default for very small return objects like in the case of 'crops'.

- also: all R functions are checked against the list of calls provided by the server. That is: if a certain server does not implement all calls the corresponding R functions will not 'insist' calling it.



# brapi 0.0.9.9014 2017-02-02

- Added a `NEWS.md` file to track changes to the package.
- Added examples for each function
- Added cross-references between funcions


