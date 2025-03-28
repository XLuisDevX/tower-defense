extends Node

var _gold: int
var _score: int
var _wave_index: int


signal gold_updated
signal score_updated
signal button_pressed

func get_gold():
	return _gold

func set_gold(gold: int):
	_gold = gold
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
