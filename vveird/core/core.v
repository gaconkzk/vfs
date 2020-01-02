module core

pub struct Position {
	x int
	y int
}

pub struct Font {

}

pub struct Color {
	r int
	g int
	b int
	a int
}

pub interface Bricker {
	draw_with(ctx &gg.GG)
	is_dirty() bool
}

pub struct Component {
mut:
	brick Bricker
pub mut:
	name string
  // brick Bricker
}

pub fn (c Component) is_dirty() bool {
	b := c.brick
	return b.is_dirty()
}

pub fn (c Component) draw_with(ctx &gg.GG) {
	b := c.brick
	b.draw_with(ctx)
}
