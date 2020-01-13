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
  fshare FShare
  vveird Vveird
}

pub struct FShare {
pub mut:
  username string
  password string
}

pub struct Vveird {
pub mut:
  width int
  height int
  font Font
}

pub struct Font {
pub mut:
  size int
  family string
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
    conf_path = './data.json'
  }

  data := os.read_file(conf_path) or {
    panic('Can\'t not read ${conf_path}.')
  }

  return from_json(data)
}
