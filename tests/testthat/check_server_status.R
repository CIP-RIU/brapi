check_server_status <- tryCatch({
  curl::curl_fetch_memory('http://127.0.0.1:2021/brapi/v1/')$status_code
  show_info(FALSE)
  connect()
}, error = function(e){
  555
})
