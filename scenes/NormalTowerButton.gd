extends TextureButton

var tower_scene = preload("res://scenes/tower.tscn")
var tower_checker_scene = preload("res://scenes/tower_checker.tscn")

@export var game: Node
@export var tower_container: Node

var current_build_prize = 0
var build_prize = 10
var tower

var tower_holded = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_check_button_status()
	if tower and tower_holded:
		tower.position = get_global_mouse_position()

func _input(event):
	if check_if_put_tower(event, tower):
		current_build_prize += build_prize
		GlobalScene.set_gold(GlobalScene.get_gold() - current_build_prize)
		tower.position = get_global_mouse_position()
		tower_holded = false
		var real_tower = tower_scene.instantiate()
		var mainNode = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
		#mainNode.add_child(real_tower)
		tower_container.add_child(real_tower)
		#print(mainNode.get_children())
		real_tower.position = tower.position
		tower.queue_free()
	#if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and tower_holded:

func check_if_put_tower(event, tower) -> bool:
	return event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and tower_holded and tower.can_build()

func _on_button_up():
	#tower = tower_scene.instantiate()
	tower = tower_checker_scene.instantiate()
	var mainNode = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	mainNode.add_child(tower)
	tower_holded = true

func _check_button_status():
	disabled = true if GlobalScene.get_gold() < current_build_prize else false
