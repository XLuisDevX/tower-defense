extends Enemy

var is_tower = false
var has_target = false
var tower_reached = false

var path_is_updated = false

var tower_target_position = null

func _init():
	call_deferred("_post_init")
	super(200, 100, 75)

func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
	
func _physics_process(delta):
	if !is_tower: _check_offset(delta)
	
	if tower_target_position == global_position:
		return_to_path_follow(delta)
		tower_target_position = null
		
	if tower_target_position:
		follow_up_tower(delta)
	else:
		if get_parent() is PathFollow2D:
			return
		else:
			if global_position == path_follow_instance.position:
				path_follow_instance.position
				var world_position = global_position
				var main_scene = get_parent()
				get_parent().remove_child(self)
				path_follow_instance.add_child(self)
				global_position = world_position
				path_follow_instance.progress = current_progress
			else:
				return_to_path_follow(delta)
	call_deferred("_check_direction")
	#_check_direction()

func _on_boss_sprite_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		#attack.emit()
		SignalBus.attack_tower.emit(20)

func set_aimed(aimed: bool):
	$Marker.visible = aimed

func _on_area_2d_area_entered(area):
	if area.is_in_group("tower") and !has_target:
		has_target = true
		#$IgniteTimer.start()
		exit_path_follow()
		tower_target_position = area.position

# Move goblin to the current tower position
func follow_up_tower(delta):
	if !tower_reached:
		global_position = global_position.move_toward(tower_target_position, speed * delta)
	else:
		$AnimatedSprite2D.play("attack")

func _on_ignite_timer_timeout():
	is_tower = true
	$AnimatedSprite2D.play("ignite")

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "ignite":
		$AnimatedSprite2D.play("walk")
		is_tower = false


func _on_hitbox_area_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		_anim_enemy("attack") if !is_game_over else _anim_enemy("idle")
		speed = 0 # stops enemy
	elif body.is_in_group("tower"):
		print(body.name)


func _on_hitbox_area_area_entered(area):
	if area.is_in_group("tower"):
		tower_reached = true
