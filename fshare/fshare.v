module fshare

import (
  http
  json
  api
  conf
)

const (
  base_url = 'https://api.fshare.vn/api'
)

fn req(method string, path string, body string, session_id string) http.Response {
  mut request := http.new_request(method, '$base_url/$path', body) or {
    panic(err)
  }

  request.add_header('User-Agent', 'okhttp/3.6.0')
  request.add_header('Content-Type', 'application/json')

  if (session_id != '') {
    request.add_header('cookie', 'session_id=$session_id')
  }

  response := request.do() or {
    panic(err)
  }

  return response
}

fn login(conf conf.Configuration) api.Session {
  login_payload := '{
  "user_email": "$conf.username",
  "password": "$conf.password",
  "app_key": "L2S7R6ZMagggC5wWkQhX2+aDi467PPuftWUMRFSn"
}'

  res := req('POST', 'user/login', login_payload, '')
  session := json.decode(api.Session, res.text) or {
    panic(err)
  }

  return session
}

pub fn new_client(conf conf.Configuration) api.Client {
  mut client := api.Client{ conf: conf }
  client.session = login(conf)

  return client
}
