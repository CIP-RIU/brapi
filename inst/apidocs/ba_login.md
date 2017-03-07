

## Call: POST [/{apipath}/{crop}/brapi/v1/token]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

ba_show_info(TRUE)

msg <- capture.output({
  con <- ba_login(con)
}, type = "message")
```

```
{
  "grant_type": ["password"],
  "username": ["user"],
  "password": ["password"],
  "client_id": [""]
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
    "status": [],
    "datafiles": []
  },
  "userDisplayName": ["John Smith"],
  "access_token": ["R6gKDBRxM4HLj6eGi4u5HkQjYoIBTPfvtZzUD8TUzg4"],
  "expires_in": [3600]
}
```

```
Authenticated!
```

```r
ba_show_info(FALSE)
```

```json

```
