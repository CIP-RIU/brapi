## ---- message=TRUE, warning=TRUE-----------------------------------------

library(brapi)
library(magrittr)

white_list <- ba_db()

# print names of databases from whitelist
white_list

sp_base <- ba_db()$sweetpotatobase

# print summary of sp_base object
sp_base


## ------------------------------------------------------------------------
ba_show_info(TRUE)

## ------------------------------------------------------------------------
ba_calls(sp_base)
ba_show_info(FALSE)

## ------------------------------------------------------------------------
ba_calls(con = sp_base, rclass = "data.frame")

## ------------------------------------------------------------------------
ba_programs(sp_base, rclass = "data.frame")

## ------------------------------------------------------------------------
ba_studies_search_get(sp_base, programDbId = "140")

## ---- message=FALSE, warning=FALSE---------------------------------------
# Currently not working!!!
#dt = ba_studies_table(sp_base, 
#                      studyDbId = "151")

## ---- echo=FALSE---------------------------------------------------------
#library(DT)
#datatable(
#  dt,
#  options=list(pageLength = 5, scrollX = TRUE)
#  )

