
## GET [/brapi/v1/germplasm/{id}/markerprofiles]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasm_markerprofiles(con, germplasmDbId = "1", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
Error in value[[3L]](cond) : 
  Error in is.ba_status_ok(res): Not Found (HTTP 404). Failed to connect due to url/BrAPI call
                                      not implemented.


Malformed request.

```


