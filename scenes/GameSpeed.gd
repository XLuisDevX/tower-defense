extends Control

const gameConst = preload("res://gameConsts.gd")
const normal_speed = preload("res://assets/ui/Buttons/Button_Blue_3Slides.png")
const normal_speed_pressed = preload("res://assets/ui/Buttons/Button_Blue_3Slides_Pressed.png")
const fast_speed = preload("res://assets/ui/Buttons/Button_Red_3Slides.png")
const fast_speed_pressed = preload("res://assets/ui/Buttons/Button_Red_3Slides_Pressed.png")

var status = gameConst.SPEED_BUTTON_STATUSES.FAST

const MENU_BTN_DOWN = gameConst.MAIN_MENU_BTN.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MAIN_MENU_BTN.BUTTON_UP

# Called when the node enters the scene tree for the first time.
func _ready():
	#_update_button_status()
	status = GlobalScene.get_game_status()
	match status:
		gameConst.SPEED_BUTTON_STATUSES.FAST:
			$Speed.texture_normal = fast_speed
			$Speed.texture_pressed = fast_speed_pressed
			$Speed/Label.text = "FAST"
		gameConst.SPEED_BUTTON_STATUSES.NORMAL:
			$Speed.texture_normal = normal_speed
			$Speed.texture_pressed = normal_speed_pressed
			$Speed/Label.text = "NORMAL"
		_:
			$Speed.texture_normal = normal_speed
			$Speed.texture_pressed = normal_speed_pressed
			$Speed/Label.text = "NORMAL"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _update_button_status():
	match status:
		gameConst.SPEED_BUTTON_STATUSES.NORMAL:
			status = gameConst.SPEED_BUTTON_STATUSES.FAST
			$Speed.texture_normal = fast_speed
			$Speed.texture_pressed = fast_speed_pressed
			$Speed/Label.text = "FAST"
		gameConst.SPEED_BUTTON_STATUSES.FAST:
			status = gameConst.SPEED_BUTTON_STATUSES.NORMAL
			$Speed.texture_normal = normal_speed
			$Speed.texture_pressed = normal_speed_pressed
			$Speed/Label.text = "NORMAL"
		_:
			status = gameConst.SPEED_BUTTON_STATUSES.NORMAL
			$Speed.texture_normal = normal_speed
			$Speed.texture_pressed = normal_speed_pressed
			$Speed/Label.text = "NORMAL"

func _update_game_speed():
	var game_speed = 2 if status == gameConst.SPEED_BUTTON_STATUSES.FAST else 1
	print_debug("SET GAME SPEED TO: ", str(game_speed))
	GlobalScene.set_game_speed(game_speed)


func _on_speed_button_up():
	GlobalScene.button_pressed.emit()
	_update_button_status()
	_update_game_speed()
