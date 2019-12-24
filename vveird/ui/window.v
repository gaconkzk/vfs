module ui

pub struct Window {
mut:
	owner voidptr
	cfg &glfw.WinCfg
pub mut:
	width int
	height int
}
