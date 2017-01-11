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
#  con = connect() # the standard parameter will work connect to a running local mock server
#  
#  # Optionally: authenticate yourself
#  
#  con = connect(user = "user", password = "password") %>% authenticate()
#  
#  crops(con) # which crops are available
#  
#  calls(con) # which calls are available
#  
#  

