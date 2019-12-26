module ui

import (
	glfw
	gl
	gg
	gx
	freetype
)

pub struct Drawer {
mut:
	current &glfw.Window
	ctx &gg.GG
	ft &freetype.FreeType
}

pub fn make_drawer() Drawer {
	mut d := Drawer {
		current: 0
		ctx: 0
		ft: 0
	}

	d.initialize()

	return d
}

pub fn (d mut Drawer) initialize() {
	glfw.init_glfw()

	w := glfw.create_window(glfw.WinCfg {
		width: 900
  	height: 800
  	borderless: false
  	title: 'VVeird'
  	ptr: d
	})
	d.current = w

	d.current.make_context_current()
  gl.init_glad()

	d.init_gg_n_font(gg.Cfg {
  	width: 900
  	height: 800
  	font_size: 14
  	use_ortho: true
  	retina: true
  	scale: 2
  	window_user_ptr: 0
	})

	d.current.set_user_ptr(d)
	d.init_generic_events()
}

fn (d mut Drawer) init_gg_n_font(cfg gg.Cfg) {
	d.ctx = gg.new_context(cfg)
	d.ft = freetype.new_context(cfg)
}

fn (d Drawer) init_generic_events() {
	mut w := d.current
	w.onkeydown(key_down)
}

fn key_down(w &glfw.Window, key, code, action, mods int) {
	if action != 2 && action != 1 {
		println('heey haha')
		return
	}
}

pub fn (d Drawer) process() {
	gl.clear()
	gl.clear_color(0, 0, 0, 255)

  for !d.current.should_close() {
		d.ctx.draw_rect(0, 0, 900, 800, gx.Color{0, 0, 0})

		d.current.swap_buffers()
		glfw.wait_events()
	}
}
