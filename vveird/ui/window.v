module ui

pub struct Window {
mut:
  owner voidptr
  cfg &glfw.WinCfg
pub mut:
  width int
  height int
}

pub fn make_window() Window {
  w := Window {
    width: 800
    height: 600
    owner: 0
    cfg: 0
  }

  return w
}

pub fn (w Window) get_owner<T>() ?T {
  if (isnil(w.owner)) {
    return error('Owner doesn\'t existed.')
  }
  return T(w.owner)
}
