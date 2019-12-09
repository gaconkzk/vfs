module main

import (
  os
  cli
  conf
)

fn main() {
  // TODO then, we will read json file from installed
  //      path, or current path
  mut conf_path := os.getenv('VFS_HOME')
  conf_path = if conf_path == '' {
    // no default location, use our default
    '${os.home_dir()}.vfs/data.json'
  } else {
    '${conf_path}/data.json'
  }
  // TODO but, is this file existed? if not, we will use default value
  // which is here
  if !os.exists(conf_path) {
    print('Configuration not existed: `$conf_path`, ')
    conf_path = './data.json'
  }
  println('Using: `$conf_path`')

  data := os.read_file(conf_path) or {
    eprintln('Can\'t not read ${conf_path}.')
    return
  }

  // TODO since v not support yaml now, so we will use
  //      JSON as default first
  // TODO initialize command definition from yml/json
  mut config := conf.from_json(data)
  // override with Environment variables
  // load from ENV first
  fs_user := os.getenv("VFS_FS_USER")
  fs_pass := os.getenv("VFS_FS_PASS")
  fs_port := os.getenv("VFS_FS_PORT")

  config.use_env(fs_user, fs_pass, fs_port)
  // TODO finally, we override it again with cli input if existed

  // current result
  println('Hello World!, $config')
}
