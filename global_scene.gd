extends Node

var _gold: int
var _score: int
var _wave_index: int
var _is_first_tower: bool = true
var _game_speed: int = 1
var _status: String = "NORMAL"


signal gold_updated
signal score_updated
signal button_pressed
signal game_speed_updated

func get_gold():
	return _gold

func set_gold(gold: int):
	_gold = gold if gold >= 0 else 0
	gold_updated.emit()
	
func get_score():
	return _score

func set_score(score: int):
	_score = score
	score_updated.emit()
	
func get_wave_index():
	return _wave_index

func set_wave_index(wave_index: int):
	_wave_index = wave_index
	
func disable_first_tower():
	if _is_first_tower: _is_first_tower = false
	
func get_is_first_tower() -> bool:
	return _is_first_tower
	
func reset_is_first_tower() -> void:
	_is_first_tower = true

func set_game_speed(speed: int) -> void:
	_game_speed = speed
	game_speed_updated.emit()
	
func get_game_speed() -> int:
	return _game_speed

func set_game_status(status: String) -> void:
	_status = status
	
func get_game_status() -> String:
	return _status
