module layout

import (
	vveird.core
	gg
)

pub struct Menu {
	position core.Position
	dirty bool
	font core.Font
	background core.Color
}

pub fn (m Menu) draw_with(ctx &gg.GG) {
}

pub fn (m Menu) is_dirty() bool {
	return true
}

pub fn (m Menu) str() string {
	return 'Im menu'
}
