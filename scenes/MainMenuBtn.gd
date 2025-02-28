extends TextureButton

const gameConst = preload("res://gameConsts.gd")

const MENU_BTN_DOWN = gameConst.MAIN_MENU_BTN.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MAIN_MENU_BTN.BUTTON_UP

func _on_button_down():
	$Label.position.y = MENU_BTN_DOWN.y


func _on_button_up():
	$Label.position.y = MENU_BTN_UP.y
