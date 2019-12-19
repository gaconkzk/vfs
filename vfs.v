module main

import (
  os
  conf
  vcli
)

fn main() {
  config := conf.load('VFS_HOME', 'data.json')
  mut cmd := vcli.cmd(config)
  cmd.parse(os.args)
}
