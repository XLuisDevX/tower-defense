extends TextureButton

const gameConst = preload("res://gameConsts.gd")

const MENU_BTN_DOWN = gameConst.MAIN_MENU_BTN.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MAIN_MENU_BTN.BUTTON_UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$Label.position.y = MENU_BTN_DOWN.y


func _on_button_up():
	$Label.position.y = MENU_BTN_UP.y
