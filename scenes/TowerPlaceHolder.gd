extends Node2D

var scoreLabel: Label
var hover_texure = preload("res://assets/ui/Icons/hammer.png")
var disable_texure = preload("res://assets/ui/Icons/hammer_disabled.png")
var tower_scene = preload("res://scenes/tower.tscn")

var place_holder_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel = get_parent().get_node("UI_gold/ScoreLabel")
	if not scoreLabel:
		print("Can not find scoreLabel node!")
	
	$ConstructionButton/Button/Prize.text = "0"
	place_holder_position = Vector2(position.x, position.y)
	GlobalScene.connect("update_prizes", Callable(self, "update_prizes"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_mouse_entered():
	if scoreLabel and int(scoreLabel.text) >= 10:
		$ConstructionButton/Button.texture_hover = hover_texure
	elif GlobalScene._is_first_tower:
		$ConstructionButton/Button.texture_hover = hover_texure
	else:
		$ConstructionButton/Button.texture_hover = disable_texure


func _on_button_button_up():
	if scoreLabel and int(scoreLabel.text) >= 10 or GlobalScene._is_first_tower:
		var new_tower = tower_scene.instantiate()
		new_tower.position = place_holder_position
		get_parent().add_child(new_tower)
		GlobalScene.disable_first_tower()
		queue_free()
	
func update_prizes():
	$ConstructionButton/Button/Prize.text = "10"
