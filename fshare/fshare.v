module fshare

import (
  http
  json
  api
  conf
)

fn login(conf conf.Configuration) api.Session {
  login_payload := '{
  "user_email": "$conf.username",
  "password": "$conf.password",
  "app_key": "L2S7R6ZMagggC5wWkQhX2+aDi467PPuftWUMRFSn"
}'
  res := http.post('/user/login', login_payload)
  session := json.decode(api.Session, login_payload) or {
    panic(err)
  }

  println(session)

  return session
}

pub fn new_client(conf conf.Configuration) api.Client {
  mut client := api.Client{ conf: conf }
  client.session = login(conf)

  return client
}
