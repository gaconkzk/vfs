module vveird

import (
	cli
	conf
)

pub fn cmd(config conf.Configuration) cli.Command {
  return cli.Command{
    name: 'vveird',
    description: 'wow a cool app',
    execute: vveird.exec,
    parent: 0,
  }
}

pub fn exec(cmd cli.Command) {
	println('start a GUI please')
}
