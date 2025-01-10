extends Control

@onready var idle_settings = preload("res://assets/ui/Icons/Regular_02.png")
@onready var pressed_settings = preload("res://assets/ui/Icons/Pressed_02.png")
@export var UI_Settings_menu: Control

var is_opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if UI_Settings_menu:
		print("Nodo asignado desde el editor "+UI_Settings_menu.name)
	else:
		print("No se ha encontrado el nodo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_button_up():
	$TextureButton/TextureRect.texture = idle_settings
	is_opened = !is_opened
	get_tree().paused = is_opened
	UI_Settings_menu.visible = is_opened


func _on_texture_button_button_down():
	$TextureButton/TextureRect.texture = pressed_settings
