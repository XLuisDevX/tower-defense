extends TextureButton

const gameConst = preload("res://gameConsts.gd")

const VOLUME_BTN_DOWN = gameConst.VOLUME_BTNS.BUTTON_PRESSED
const VOLUME_BTN_UP = gameConst.VOLUME_BTNS.BUTTON_UP
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$UpTexture.position.y = VOLUME_BTN_DOWN.y


func _on_button_up():
	$UpTexture.position.y = VOLUME_BTN_UP.y
