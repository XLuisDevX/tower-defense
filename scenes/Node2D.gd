extends Node2D

var og_pos = null
var target_position = Vector2(481, 370)
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("TEST ", get_parent())
	#print("TEST ", position)
	#print("TEST ", global_position)
	#print("TEST ", global_transform)
	og_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position == target_position:
		print('return to original')
		target_position = null
	
	if target_position:
		print('go to target')
		global_position = global_position.move_toward(target_position, 75 * delta)
	else:
		global_position = global_position.move_toward(og_pos, 75 * delta)
