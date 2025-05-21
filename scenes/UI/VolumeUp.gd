extends TextureButton

const gameConst = preload("res://gameConsts.gd")

@export var volume_slider: HSlider

const VOLUME_BTN_DOWN = gameConst.VOLUME_BTNS.BUTTON_PRESSED
const VOLUME_BTN_UP = gameConst.VOLUME_BTNS.BUTTON_UP
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	GlobalScene.button_pressed.emit()
	$UpTexture.position.y = VOLUME_BTN_DOWN.y


func _on_button_up():
	$UpTexture.position.y = VOLUME_BTN_UP.y
	_update_slider_value()
	
func _update_slider_value():
	var current_value = volume_slider.value
	var new_value_to_slider = volume_slider.value + 5
	var value_to_db = linear_to_db((current_value + 5) / 100)
	var new_volume = minf(0.0, value_to_db)
	print_debug("limited new value: ", new_volume)
	volume_slider.value = new_value_to_slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), new_volume )
	
