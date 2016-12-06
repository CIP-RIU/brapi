check_server_status <- tryCatch({
  curl::curl_fetch_memory('http://127.0.0.1:2021/brapi/v1/')$status_code
}, error = function(e){
  555
})

brapi::connect()

#
# brapi <<- list(
#   crop = "sweetpotato",
#   db = '127.0.0.1',
#   port = 2021,
#   user = "rsimon",
#   password = "password",
#   session = "",
#   protocol = "http://"
# )
#
