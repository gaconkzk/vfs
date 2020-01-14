module core

import ui

pub struct Component {
	config Config
	widget &ui.IWidgeter
}

pub struct Config {
	kind string
	position Position
	size Size
}

pub struct Position {
	x int
	y int
}

pub struct Size {
	width int
	height int
}

pub fn (c Component) make(config Config) {
	return Component{
		config: config
		position: Position{ x: 0, y: 0 }
		size: Size{width: 5, height: 10}
	}
}
