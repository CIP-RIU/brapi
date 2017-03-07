

## Call: DELETE [/{apipath}/{crop}/brapi/v1/token]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()
con <- ba_login(con)
```

```
Authenticated!
```

```r
ba_show_info(TRUE)

msg <- capture.output({
  con <- ba_logout(con)
}, type = "message")
```

```
{
  "access_token": ["R6gKDBRxM4HLj6eGi4u5HkQjYoIBTPfvtZzUD8TUzg4"]
}
```

```
{
  "metadata": {
    "pagination": {
      "pageSize": [0],
      "currentPage": [0],
      "totalCount": [0],
      "totalPages": [0]
    },
    "status": [
      {
        "message": ["User has been logged out successfully."]
      }
    ],
    "datafiles": []
  },
  "result": {}
}
```

```
Successfully logged out!
```

```r
ba_show_info(FALSE)
```

```json

```

