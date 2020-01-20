module fshare

import (
  net.http
  json
  conf
  os
  cli
)

const (
  base_url = 'https://fshare.vn/api'
)

fn req(method string, path string, body string, session_id string) http.Response {
  mut fetch_config := http.FetchConfig {
    method: method
    data: body
    headers: {
      'User-Agent': 'okhttp/3.6.0'
      'Content-Type': 'application/json'
    }
  }
  if (session_id != '') {
    fetch_config.headers['cookie'] = 'session_id=$session_id'
  }

  response := http.fetch('$base_url/$path', fetch_config) or {
    panic(err)
  }

  return response
}

fn login(conf conf.FShare) Session {
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

pub fn new_client(conf conf.FShare) Client {
  mut client := Client{ conf: conf }
  client.session = login(conf)

  return client
}

pub fn cmd(config conf.FShare) cli.Command {
  mut fs_cmd := cli.Command{
    name: 'fshare',
    description: 'Fshare tool',
    execute: fshare.exec,
    parent: 0,
  }

  fs_cmd.add_flag(cli.Flag{
    flag: .string,
    required: true,
    name: 'user',
    abbrev: 'u',
    value: config.username,
    description: 'fshare vip account',
  })

  fs_cmd.add_flag(cli.Flag{
    flag: .string,
    required: true,
    name: 'pass',
    abbrev: 'p'
    value: config.password,
    description: 'fshare vip password',
  })

  return fs_cmd
}

pub fn exec(cmd cli.Command) {
  user := cmd.flags.get_string('user') or { os.getenv("VFS_FS_USER") }
  pass := cmd.flags.get_string('pass') or { os.getenv("VFS_FS_PASS") }

  config := conf.FShare{
    username: user,
    password: pass,
  }

  println(config)

  // client := fshare.new_client(config)
}
