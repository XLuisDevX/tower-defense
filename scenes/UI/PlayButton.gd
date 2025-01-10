extends TextureButton

const gameConst = preload("res://gameConsts.gd")

const MENU_BTN_DOWN = gameConst.MENU_BTN_TEXT.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MENU_BTN_TEXT.BUTTON_UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$Label.position.y = MENU_BTN_DOWN.y
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_up():
	$Label.position.y = MENU_BTN_UP.y
