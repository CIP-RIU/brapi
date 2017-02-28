check_server_status <- tryCatch({
  curl::curl_fetch_memory("http://127.0.0.1:2021/brapi/v1/")$status_code
  ba_show_info(FALSE)
  ok <- ba_connect(secure = FALSE)
  ok <- ba_connect(ba_db()$mockbase, secure = FALSE)
  200
},
error = function(e){
  555
})
