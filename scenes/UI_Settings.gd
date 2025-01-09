extends Control

@onready var idle_settings = preload("res://assets/ui/Icons/Regular_02.png")
@onready var pressed_settings = preload("res://assets/ui/Icons/Pressed_02.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_button_up():
	$TextureButton/TextureRect.texture = idle_settings


func _on_texture_button_button_down():
	$TextureButton/TextureRect.texture = pressed_settings
