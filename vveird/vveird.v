module vveird

import (
  cli
  conf
  // gl
  // gg
  // glfw
  // gx
  // freetype
  // time
  ui
)

const (
	win_width = 600
	win_height = 385
	nr_colrs = 3
	cell_height = 25
	cell_width = 100
	table_width = cell_width * nr_colrs
)

struct Context {
mut:
  components []&ui.IWidgeter
  // first_name &ui.TextBox

  window &ui.Window
}

pub fn cmd(config conf.Vveird) cli.Command {
  wcmd := cli.Command{
    name: 'vveird'
    description: 'wow a cool app'
    execute: vveird.exec
    parent: 0
  }

  return wcmd
}

pub fn exec(cmd cli.Command) {
  // todo - window config from cmd
  mut ctx:= &Context{ window: 0 }
  window := ui.new_window(ui.WindowConfig{
    width: 900
    height: 600
    title: 'Vveird'
    user_ptr: ctx
    draw_fn: draw
  })
  ctx.components << ui.new_textbox(ui.TextBoxConfig{
    max_len: 20
    x: 20
    y: 20
    width: 200
    placeholder: 'First name'
    parent: window
  })

  ctx.window = window
  ui.run(window)
}

fn draw(ctx &Context) {
  // gg := ctx.window.ctx.gg
  // mut ft := ctx.window.ctx.ft
  // x:= 200
  // gg.draw_rect(x - 20, 0, table_width + 100, 800, gx.white)
}
