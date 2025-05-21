extends TextureButton


const gameConst = preload("res://gameConsts.gd")
const normal_speed = preload("res://assets/ui/Buttons/Button_Blue_3Slides.png")
const normal_speed_pressed = preload("res://assets/ui/Buttons/Button_Blue_3Slides_Pressed.png")
const fast_speed = preload("res://assets/ui/Buttons/Button_Red_3Slides.png")
const fast_speed_pressed = preload("res://assets/ui/Buttons/Button_Red_3Slides_Pressed.png")

var status = gameConst.SPEED_BUTTON_STATUSES.NORMAL

const MENU_BTN_DOWN = gameConst.MAIN_MENU_BTN.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MAIN_MENU_BTN.BUTTON_UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	GlobalScene.button_pressed.emit()
	_update_button_status()
	_update_game_speed()


func _on_button_down():
	pass
	
func _update_button_status():
	match status:
		gameConst.SPEED_BUTTON_STATUSES.NORMAL:
			status = gameConst.SPEED_BUTTON_STATUSES.FAST
			texture_normal = fast_speed
			texture_pressed = fast_speed_pressed
			$ButtonText.text = "FAST"
		gameConst.SPEED_BUTTON_STATUSES.FAST:
			status = gameConst.SPEED_BUTTON_STATUSES.NORMAL
			texture_normal = normal_speed
			texture_pressed = normal_speed_pressed
			$ButtonText.text = "NORMAL"
		_:
			status = gameConst.SPEED_BUTTON_STATUSES.NORMAL
			texture_normal = normal_speed
			texture_pressed = normal_speed_pressed
			$ButtonText.text = "NORMAL"

func _update_game_speed():
	var game_speed = 2 if status == gameConst.SPEED_BUTTON_STATUSES.FAST else 1
	GlobalScene.set_game_speed(game_speed)
