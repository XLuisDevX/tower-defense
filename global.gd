extends Node

var _is_first_tower: bool = true

signal update_prizes

func disable_first_tower():
	_is_first_tower = false
	update_prizes.emit()
