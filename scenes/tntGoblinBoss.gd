extends Enemy

var dynamite_scene = preload("res://scenes/dynamite.tscn")
var _attack_timer
var _is_tower: bool = false
var _tower: Node2D

func _init():
	call_deferred("post_init")
	super(200, 100, 100)

func post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
	_attack_timer = _create_timer(2, true)

func _create_timer(wait_time: int, one_shot: bool = true) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.one_shot = one_shot
	add_child(timer)
	return timer
	
# TODO: Create a method that detects towers and decide in 50/50 if the goblin should attack a tower or not
func _physics_process(delta):
	if _is_tower == false:
		# Choose if attack the tower or keep walking
		#if _should_attack_tower():
			#_attack_tower()
		#else:
			#_check_offset(delta)
		#_attack_tower()
	#else:
		_check_offset(delta)
	_check_direction()

# TODO: Create a method that detects when the goblin reach player position so the golbin imbolates and cause massive damage
func _check_offset(delta) -> void:
	var path_follow = get_parent() as PathFollow2D
	path_follow.progress += speed * delta
	if path_follow.progress >= 1.0:
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
	#pass
	_anim_enemy("attack")

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 3 and $AnimatedSprite2D.animation == "attack":
		#var dynamite = dynamite_scene.instantiate()
		#add_child(dynamite)
		_shoot_at_player(_tower)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		_is_tower = false
		var anim = "idle" if _is_tower else "walk"
		_anim_enemy(anim)
		_attack_timer.start()
		_attack_timer.timeout.connect(Callable(self, "on_attack_timeout"))

func _shoot_projectile(goblin_pos: Vector2, player_pos: Vector2, gravity: float, t_total: float) -> Vector2:
	var displacement = player_pos - goblin_pos
	
	var vx = displacement.x / t_total
	var vy = (displacement.y - 0.5 * gravity * t_total * t_total) / t_total
	
	return Vector2(vx, vy)
	
func _shoot_at_player(player: Node2D) -> void:
	var dynamite = dynamite_scene.instantiate()
	add_child(dynamite)
	#dynamite.set_alive(true)
	#dynamite.position = global_position
	
	var vel = _shoot_projectile(global_position, player.global_position, 300, 1)
	dynamite.set_velocity(vel)
	#dynamite.set_alive(true)
	
func set_aimed(aimed: bool) -> void:
	$Marker.visible = aimed

# Detects when the goblin entered a tower area
func _on_area_2d_area_entered(area):
	if area.is_in_group("tower"):
		_is_tower = true
		_tower = area
		_attack_tower()

# Detects when the goblin exited the a tower area
func _on_area_2d_area_exited(area):
	if area.is_in_group("tower"):
		_is_tower = false
		#_anim_enemy("idle")

func on_attack_timeout():
	if _is_tower:
		_anim_enemy("attack")


func emit_attack_signal():
	SignalBus.attack_tower.emit(20)

#endregion ATTACK_TOWER

#region INMOLATE

#endregion INMOLATE
