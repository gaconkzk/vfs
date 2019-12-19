module vcli

import (
	cli
	conf
	fshare
  vveird
)

pub fn cmd(config conf.Configuration) cli.Command {
  mut cmd := cli.Command{
    name: 'vfs',
    description: 'VFS me cool',
    version: '1.0.0',
    parent: 0,
  }

	cmd.add_command(fshare.cmd(config.fshare))

  cmd.add_command(vveird.cmd(config))
	return cmd
}
