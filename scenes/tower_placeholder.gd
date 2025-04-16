extends Node2D

var scoreLabel: Label
var hover_texure = preload("res://assets/ui/Icons/hammer.png")
var disable_texure = preload("res://assets/ui/Icons/hammer_disabled.png")
var tower_scene = preload("res://scenes/tower.tscn")
var build_prize = 10

var place_holder_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel = get_parent().get_node("UI_gold/ScoreLabel")
	if not scoreLabel:
		print("Can not find scoreLabel node!")
	
	$UI/Prize.text = "0"
	place_holder_position = Vector2(position.x, position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_prizes():
	var placeholders = get_tree().get_nodes_in_group("placeholder")
	build_prize = build_prize * get_tree().get_nodes_in_group("tower").size()
	for placeholder in placeholders:
		placeholder.get_node("UI/Prize").text = str(build_prize)
	#$UI/Prize.text = "10"

func play_build_sound_effect():
	var build_sound = AudioStreamPlayer.new()
	build_sound.stream = load("res://assets/sounds/BuildButtonSound.mp3")
	build_sound.autoplay = true
	build_sound.connect("finished", Callable(self, "_on_sound_finished"))
	add_child(build_sound)

func hide_placeholder():
	visible = false
	
func instantiate_tower():
	var new_tower = tower_scene.instantiate()
	new_tower.position = place_holder_position
	get_parent().add_child(new_tower)
	Global.disable_first_tower()

func _on_build_button_mouse_entered():
	if scoreLabel and int(scoreLabel.text) >= build_prize:
		$UI/BuildButton.texture_hover = hover_texure
	elif Global._is_first_tower:
		$UI/BuildButton.texture_hover = hover_texure
	else:
		$UI/BuildButton.texture_hover = disable_texure


func _on_build_button_button_up():
	if scoreLabel and int(scoreLabel.text) >= build_prize or Global._is_first_tower:
		GlobalScene.set_gold(GlobalScene.get_gold() - build_prize)
		play_build_sound_effect()
		hide_placeholder()
		instantiate_tower()
		update_prizes()
		
func _on_sound_finished():
	queue_free()
