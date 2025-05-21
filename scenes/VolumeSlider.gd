extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_value_changed(value):
	if value_changed:
		var current_volume = maxf(value, 0.01)
		var new_volume = linear_to_db(current_volume / 100)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume )
