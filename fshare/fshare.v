module fshare

import (
  http
  json
  conf
  os
)

const (
  base_url = 'https://fshare.vn/api'
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

fn login(conf conf.Configuration) Session {
  login_payload := '{
  "user_email": "$conf.username",
  "password": "$conf.password",
  "app_key": "L2S7R6ZMagggC5wWkQhX2+aDi467PPuftWUMRFSn"
}'

  res := req('POST', 'user/login', login_payload, '')
  session := json.decode(Session, res.text) or {
    panic(err)
  }

  return session
}

pub fn new_client(conf conf.Configuration) Client {
  mut client := Client{ conf: conf }
  client.session = login(conf)

  return client
}

pub fn exec(cmd cli.Command) {
  user := cmd.flags.get_string('user') or { os.getenv("VFS_FS_USER") }
  pass := cmd.flags.get_string('pass') or { os.getenv("VFS_FS_PASS") }

  config := conf.Configuration{
    username: user,
    password: pass,
  }

  println(config)

  client := fshare.new_client(config)
}
