extends TextureButton

const gameConst = preload("res://gameConsts.gd")

const CLOSE_BTN_PRESSED = gameConst.CLOSE_SETTINGS_BTN.BUTTON_PRESSED
const CLOSE_BTN_UP = gameConst.CLOSE_SETTINGS_BTN.BUTTON_UP

signal close_settings

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$Cross.position.y = CLOSE_BTN_PRESSED.y
	close_settings.emit()
	GlobalScene.button_pressed.emit()
	# Emitir señal para cerrar ajustes



func _on_button_up():
	$Cross.position.y = CLOSE_BTN_UP.y
