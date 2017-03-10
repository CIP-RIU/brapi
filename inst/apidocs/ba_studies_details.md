
## GET [/brapi/v1/studies/{studyDbId}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_details(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
Error in value[[3L]](cond) : 
  Error in is.ba_status_ok(res): Not Found (HTTP 404). Failed to connect due to url/BrAPI call
                                      not implemented.


Malformed request.

```


