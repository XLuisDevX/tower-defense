extends TextureButton

const game_constants = preload("res://gameConsts.gd")

const SETTINGS_BTN_UP = game_constants.SETTINGS_BUTTON["BUTTON_UP"]
const SETTINGS_BTN_DOWN = game_constants.SETTINGS_BUTTON["BUTTON_PRESSED"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$TextureRect.position.y = SETTINGS_BTN_DOWN.y
	GlobalScene.button_pressed.emit()
	get_parent().emit_signal("settings_pressed")
	


func _on_button_up():
	$TextureRect.position.y = SETTINGS_BTN_UP.y
