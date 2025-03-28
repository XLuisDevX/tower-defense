extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	print('set volume: ', db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 100)
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 100
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_drag_ended(value_changed):
	GlobalScene.button_pressed.emit()
	if value_changed:
		var current_volume = max(value, 0.01)
		print('curent volume: ', current_volume)
		var new_volume = linear_to_db(current_volume / 100)
		print('new volume: ', new_volume)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume )
