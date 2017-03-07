

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
Successfully logged out!
```

```json

```


```r
ba_show_info(FALSE)
```
