extends Node

var _is_first_tower: bool = true

func disable_first_tower():
	if _is_first_tower: _is_first_tower = false
	
func get_is_first_tower() -> bool:
	return _is_first_tower
