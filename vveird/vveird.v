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
  ui
)

struct Context {
mut:
  first_name &ui.TextBox

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

  mut ctx:= &Context{}

  window := ui.new_window(ui.WindowConfig{
    width: 900
    height: 600
    title: 'Vveird'
    user_ptr: ctx
    draw_fn: draw
  })

  ctx.first_name = ui.new_textbox(ui.TextBoxConfig{
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

fn draw(ctx mut Context) {

}
