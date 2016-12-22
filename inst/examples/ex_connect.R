if(interactive()){
  if(can_internet("http://127.0.0.1:2021/brapi/v1")){

    connect()

    calls()

    crops()

  }
}
