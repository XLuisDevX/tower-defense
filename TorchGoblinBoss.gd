extends Enemy

var is_tower = false
var has_target = false
var tower_reached = false

var _BOSS_HEALTH = 200
var _BOSS_SCORE = 100
var _BOSS_SPEED = 75
var _BOSS_DAMAGE = 50
var _BOSS_GOLD_AWARD = 50

var _damage_increment_factor = 0.5
var _health_increment_factor = 0.5
var _speed_increment_factor = 0.25

var path_is_updated = false

var tower_target_position = null

func _init():
	call_deferred("_post_init")
	if GlobalScene.get_wave_index() % 5 == 0 and GlobalScene.get_wave_index() != 5:
		_update_boss_attributes()
		
	super(_BOSS_HEALTH, _BOSS_SCORE, _BOSS_SPEED)

func _post_init():
	_set_gold_award(_BOSS_GOLD_AWARD)
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

func set_aimed(aimed: bool):
	$Marker.visible = aimed

func _update_boss_attributes():
	_BOSS_DAMAGE = round( _BOSS_DAMAGE + _BOSS_DAMAGE * _damage_increment_factor)
	_BOSS_HEALTH = round(_BOSS_HEALTH +  _BOSS_HEALTH * _health_increment_factor)
	_BOSS_SPEED = round(_BOSS_SPEED + _BOSS_SPEED + _speed_increment_factor)
# Move goblin to the current tower position
func follow_up_tower(delta):
	if !tower_reached:
		global_position = global_position.move_toward(tower_target_position, speed * delta)
	else:
		$AnimatedSprite2D.play("attack")

#region SIGNALS
func _on_ignite_timer_timeout():
	is_tower = true
	$AnimatedSprite2D.play("ignite")

func on_attack_timer_timeout():
	_anim_enemy("attack")

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "ignite":
		$AnimatedSprite2D.play("walk")
		is_tower = false
	elif $AnimatedSprite2D.animation == "attack":
		SignalBus.attack_tower.emit(_BOSS_DAMAGE)
		$AnimatedSprite2D.play("idle")
		if is_tower:
			var timer = Timer.new()
			timer.one_shot = true
			timer.wait_time = 2
			add_child(timer)
			timer.start()
			timer.timeout.connect(Callable(self, "on_attack_timer_timeout"))
		else:
			set_aimed(false)
			$AnimatedSprite2D.play("walk")

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

func _on_hitbox_area_area_exited(area):
	if area.is_in_group("tower"):
		is_tower = false
		tower_target_position = null
	#print_debug(area.is_in_group("tower"))

func _on_area_2d_area_entered(area):
	if area.is_in_group("tower") and !has_target:
		has_target = true
		#$IgniteTimer.start()
		exit_path_follow()
		tower_target_position = area.position

func _on_boss_sprite_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		#attack.emit()
		SignalBus.attack_tower.emit(_BOSS_DAMAGE)

#endregion






