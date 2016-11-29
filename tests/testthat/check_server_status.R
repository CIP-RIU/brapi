check_server_status <- tryCatch({
  curl::curl_fetch_memory('http://127.0.0.1:2021/brapi/v1/')$status_code
}, error = function(e){
  #list(status_code = 555)
  # message("Could not connect to local BrAPI server.")
  # message("Start a server in an independent command line window\nusing brapi::mock_server().")
  555
})
