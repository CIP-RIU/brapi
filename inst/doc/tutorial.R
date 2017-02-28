## ----eval=FALSE----------------------------------------------------------
#  
#  brapiTS::mock_server()
#  

## ----eval=FALSE----------------------------------------------------------
#  
#  R -e "brapiTS::mock_server()"
#  

## ----eval=FALSE----------------------------------------------------------
#  library(brapi)
#  
#  con = ba_connect() # the standard parameter will work connect to a running local mock server
#  
#  # Optionally: authenticate yourself
#  
#  con = ba_connect(user = "user", password = "password") %>% ba_authenticate()
#  
#  ba_crops(con) # which crops are available
#  
#  ba_calls(con) # which calls are available
#  
#  

