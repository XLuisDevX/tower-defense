extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Normal.connect("speed_button_pressed",Callable(self, "update_game_speed_buttons"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_game_speed_buttons():
	print('Speed button status')
	print('Normal: ', $Normal.toggle_mode)
	print('Fast: ', $Fast.toggle_mode)
	


func _on_normal_toggled(toggled_on):
	GlobalScene.button_pressed.emit()
	$Normal.button_pressed = toggled_on
	$Fast.button_pressed = !toggled_on
	update_game_speed_buttons()


func _on_fast_toggled(toggled_on):
	GlobalScene.button_pressed.emit()
	$Normal.button_pressed = !toggled_on
	$Fast.button_pressed = toggled_on
	update_game_speed_buttons()
