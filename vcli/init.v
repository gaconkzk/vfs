module vcli

import (
	cli
	conf
	fshare
)

pub fn init_command(config conf.Configuration) cli.Command {
  mut cmd := cli.Command{
    name: 'vfs',
    description: 'VFS me cool',
    version: '1.0.0',
  }

  mut fs_cmd := cli.Command{
    name: 'fshare',
    description: 'Fshare tool',
    execute: fshare.exec,
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

	cmd.add_command(fs_cmd)
	return cmd
}
