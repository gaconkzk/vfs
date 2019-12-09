module conf

import (
  strings
  json
)

/**
 * Credentials and Server config
 */
pub struct Configuration {
pub mut:
  port     int
  username string
  password string
}

// V-BUG-001: .str not available until we try to construct
//        a simple Configuration object first
// V-BUG-001: can't print struct since .str not available
fn (c Configuration) str() string {
  // masking password
  pass := strings.repeat(`*`, c.password.len)
  return 'Configuration(username: $c.username, password: $pass, port: $c.port)'
}

pub fn (c mut Configuration) use_env(fs_user string, fs_pass string, fs_port string) {
  if fs_user != '' {
    c.username = fs_user
  }

  if fs_pass != '' {
    c.password = fs_pass
  }

  if fs_port != '' {
    c.port = fs_port.int()
  }
}

pub fn from_json(data string) Configuration {
  config := json.decode(Configuration, data) or {
    panic(err)
  }

  return config
}
