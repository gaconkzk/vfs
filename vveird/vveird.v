module vveird

import (
	cli
	conf
	gl
	gg
	glfw
	gx
	freetype
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

pub fn exec(cmd cli.Command) {
	println('start a GUI please')

	ui.start()
	// todo - window config from cmd
  mut vveird := &Vveird {
		main: 0
		vg: 0
		ft: 0
	}

	w := glfw.create_window(glfw.WinCfg {
		width: 900
		height: 800
		borderless: false
		title: 'VVeird'
		ptr: vveird
	})

	vveird.main = w

	w.make_context_current()
	gl.init_glad()

	// gg config
	cfg := gg.Cfg {
		width: 900
		height: 800
		font_size: 14
		use_ortho: true
		retina: true
		scale: 2
		window_user_ptr: 0
	}
	vveird.vg = gg.new_context(cfg)

	// font
	vveird.ft = freetype.new_context(cfg)

	w.set_user_ptr(vveird)

	go vveird.loop()

	gl.clear()
	gl.clear_color(0, 0, 0, 255)

	vveird.refresh = true
	for !vveird.main.should_close() {
		if vveird.refresh {
			gl.clear()
			gl.clear_color(0, 0, 0, 255)
		}

		vveird.draw()

		w.swap_buffers()
		glfw.wait_events()
	}
}

pub struct Vveird {
mut:
	states States

	main &glfw.Window
	vg &gg.GG
	ft &freetype.FreeType

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

fn (vveird Vveird) draw() {
	vveird.vg.draw_rect(0, 0, 900, 800, gx.Color {0, 0, 0})
}
