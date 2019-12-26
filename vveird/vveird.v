module vveird

import (
  cli
  conf
  // gl
  // gg
  glfw
  // gx
  // freetype
  time
  vveird.ui
)

pub fn cmd(config conf.Window) cli.Command {
  wcmd := cli.Command{
    name: 'vveird'
    description: 'wow a cool app'
    execute: vveird.exec
    parent: 0
  }

  return wcmd
}

fn (v mut Vveird) set_drawer(d ui.Drawer) {
  v.drawer = d
}

pub fn exec(cmd cli.Command) {
  // todo - window config from cmd

  mut vveird := &Vveird{
    main: 0
  }

  vveird.set_drawer(ui.make_drawer())

  // todo adding components
  // menu := ...
  // left_sidebar := ...
  // right_sidebar := ...
  // content := ...
  // layout := ...
  // vveird.layout(layout)

  vveird.process()
}

fn (v Vveird) draw() {
  println('draw')

  time.sleep(5)
}

fn (v Vveird) process() {
  v.drawer.process()
}

pub struct Vveird {
mut:
  drawer ui.Drawer
  states States

  main &ui.Window
  // vg &gg.GG
  // ft &freetype.FreeType

  refresh bool
}

pub struct User {
  email string
  full_name string
  password string
}

pub struct Position {
  x int
  y int
}

pub struct States {
  users []User
}

fn (vveird mut Vveird) loop() {
	for {
		vveird.refresh = true
		glfw.post_empty_event()

		//

		time.sleep(5)
	}
}

// fn (vveird Vveird) draw() {
// 	vveird.vg.draw_rect(0, 0, 900, 800, gx.Color {0, 0, 0})
// }
