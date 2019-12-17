module conf

import (
  os
  json
)

/**
 * Credentials and Server config
 */
pub struct Configuration {
pub mut:
  username string
  password string
}

// V-BUG-001: .str not available until we try to construct
//        a simple Configuration object first
// V-BUG-001: can't print struct since .str not available
// fn (c Configuration) str() string {
//   // masking password
//   pass := strings.repeat(`*`, c.password.len)
//   return 'Configuration(username: $c.username, password: $pass, port: $c.port)'
// }

pub fn (c mut Configuration) use_env(fs_user string, fs_pass string ) {
  if fs_user != '' {
    c.username = fs_user
  }

  if fs_pass != '' {
    c.password = fs_pass
  }
}

fn from_json(data string) Configuration {
  config := json.decode(Configuration, data) or {
    panic(err)
  }

  return config
}


pub fn load(env string, file_name string) Configuration {
  mut conf_path := os.getenv(env)
  conf_path = if conf_path == '' {
    // no default location, use our default
    '${os.home_dir()}.vfs/$file_name'
  } else {
    '${conf_path}/$file_name'
  }

  if !os.exists(conf_path) {
    print('Configuration not existed: `$conf_path`, ')
    conf_path = './data.json'
  }

  println('Using: `$conf_path`')

  data := os.read_file(conf_path) or {
    eprintln('Can\'t not read ${conf_path}.')
    exit(-1)
  }

  return from_json(data)
}
