extends Control

const gameConst = preload("res://gameConsts.gd")

const MENU_BTN_DOWN = gameConst.MAIN_MENU_BTN.BUTTON_PRESSED
const MENU_BTN_UP = gameConst.MAIN_MENU_BTN.BUTTON_UP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_anim(anim: String):
	visible = true
	$Banner/AnimPlayer.play("pop_up")


func _on_retry_button_button_up():
	get_tree().reload_current_scene()


func _on_anim_player_animation_finished(anim_name):
	$RetryButton.visible = true


func _on_main_menu_btn_button_down():
	$MainMenuBtn/Label.position.y = MENU_BTN_DOWN.y


func _on_main_menu_btn_button_up():
	$MainMenuBtn/Label.position.y = MENU_BTN_UP.y
	get_tree().change_scene_to_file("res://scenes/UI/MainMenu.tscn")
