extends Enemy

var _is_tower: bool = false

func _init():
	call_deferred("post_init")
	super(200, 100, 100)

func post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)

# TODO: Create a method that detects towers and decide in 50/50 if the goblin should attack a tower or not
func _physics_process(delta):
	if _is_tower:
		# Choose if attack the tower or keep walking
		if _should_attack_tower():
			_attack_tower()
		else:
			_check_offset(delta)
	else:
		_check_offset(delta)
	_check_direction()

# TODO: Create a method that detects when the goblin reach player position so the golbin imbolates and cause massive damage
func _check_offset(delta) -> void:
	var path_follow = get_parent() as PathFollow2D
	path_follow.progress += speed * delta
	if path_follow.progress >= 1.0:
		print('XXXX')
		pass
		# Play inmolate animation
		#_anim_enemy("inmolate")
		#path_follow.h_offset = 0

#region ATTACK_TOWER
func _should_attack_tower() -> bool:
	if randi_range(0,1) == 0:
		return true
	else:
		return false

func _attack_tower() -> void:
	pass

# Detects when the goblin entered a tower area
func _on_area_2d_area_entered(area):
	if area.is_in_group("tower"):
		_is_tower = true

# Detects when the goblin exited the a tower area
func _on_area_2d_area_exited(area):
	if area.is_in_group("tower"):
		_is_tower = false

#endregion ATTACK_TOWER

#region INMOLATE

#endregion INMOLATE
