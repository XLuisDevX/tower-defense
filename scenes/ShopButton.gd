extends TextureButton

var shop_icon_texture_pressed = preload("res://assets/ui/Icons/Pressed_07.png")
var shop_icon_texture_release = preload("res://assets/ui/Icons/Regular_07.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	$ShopIcon.texture = shop_icon_texture_pressed


func _on_button_up():
	$ShopIcon.texture = shop_icon_texture_release
