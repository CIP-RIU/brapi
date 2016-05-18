
# construct a sample object
library(brapi)

brapi = brapi_con("potato", "http://sample.com", 8080, "rs", "pwd")

is.brapi(brapi)

brapi
