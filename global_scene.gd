extends Node

var _gold: int

signal gold_updated

func get_gold():
	return _gold

func set_gold(gold: int):
	_gold = gold
	gold_updated.emit()
