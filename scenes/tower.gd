extends Area2D

var Projectile = preload("res://scenes/arrow.tscn")
var idle_attack_speed = preload("res://assets/ui/Icons/Regular_11.png")
var pressed_attack_speed = preload("res://assets/ui/Icons/Pressed_11.png")
var idle_increase_attack = preload("res://assets/ui/Icons/Regular_12.png")
var pressed_increase_attack = preload("res://assets/ui/Icons/Pressed_12.png")

var _objects_inside = []
var _prev_orientation = ""
var _arrow_speed = 600
var _attack_speed_level = 1
var _damage_level = 1
var shooted = false
var flipped = false
var _throw_arrow = false
var _play_throw_anim = true
var archer_anim = "idle"
var _tower_damage = 20
var _current_speed = 1
var upgrade_attack_speed_prize = 5
var upgrade_damage_prize = 5
var scoreLabel: Label

var UPGRADE_MAX_LEVEL = 5
var padding: Vector2 = Vector2(10,5)


# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel = get_parent().get_parent().get_node("UI_Gold_Control/UI_Gold_Panel/ScoreLabel")
	if not scoreLabel:
		print_debug("Can not find scoreLabel node!")
		
	#$Improvements/AttackSpeed/Prize.text = str(upgrade_attack_speed_prize)
	#$Improvements/Damage/Prize.text = str(upgrade_damage_prize)
	_update_tower_interface($Improvements/AttackSpeed/Prize, upgrade_attack_speed_prize)
	_update_tower_interface($Improvements/Damage/Prize, upgrade_damage_prize)
	
	
	GlobalScene.connect("game_speed_updated", Callable(self, "_update_tower_speed"))
	
	$Archer.speed_scale = 1 * GlobalScene.get_game_speed()
	_anim_archer(archer_anim, false)

	#_play_build_sound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for obj in _objects_inside:
		#if obj and obj.get_parent() is PathFollow2D:
			#var enemy = obj.get_parent()
			#var path_follow = obj.get_parent()
			#target_and_shoot(enemy, delta)
	if _objects_inside.size() > 0:
		if is_instance_valid(_objects_inside[0]) and _objects_inside[0].is_inside_tree():
			_objects_inside[0].set_aimed(true)
			var enemy = _objects_inside[0]
			var path_follow = enemy.get_parent()
			target_and_shoot(enemy, delta)
	
# Receives an object with the enemy position, then modify the archer sprite and shoot the enemy
func target_and_shoot(enemy, delta):
	$FireRate.start()
	var archer_position = $Archer.global_position
	var enemy_position = enemy.global_position
	#var archer_anim = "idle"
	var flip_h = false
	#var future_position = _get_future_position(archer_position, enemy, delta)
	# Check the enemy's position rescpect archer's position to determinate if it's on the right, left, top or down
	var orientation = _get_orientation(enemy_position, archer_position)
	if orientation != _prev_orientation:
		# Notify acher to flip and change animation
		#archer_anim = _get_archer_anim(orientation) if _play_throw_anim else "idle"
		#print("Archer anim: ", archer_anim)
		#flip_h = _has_to_flip_h(orientation)
		#_anim_archer(archer_anim, flip_h)
		_prev_orientation = orientation
	archer_anim = _get_archer_anim(_prev_orientation) if _play_throw_anim else "idle"
	flip_h = _has_to_flip_h(orientation)
	flipped = flip_h
	_anim_archer(archer_anim, flip_h)
	# Shoot
	#_shoot(future_position, archer_anim, flip_h)

func _get_future_position(archerPos, enemy, delta):
	var enemy_position = enemy.global_position
	# Get the distance between archer and target
	var distance = archerPos.distance_to(enemy_position)
	# Path length
	var path_length = 0
	if enemy.get_parent():
		path_length = enemy.get_parent().curve.get_baked_length()
	else:
		path_length = 1
	
	# Get enemy's velocity
	var target_velocity_h = enemy.h_offset / path_length
	var target_velocity_v = enemy.v_offset / path_length
	
	var intercept_time = distance / _arrow_speed
	
	# Calculate the future position of enemy
	var future_h_offset = enemy.h_offset + (target_velocity_h  * 100)
	var future_v_offset = enemy.v_offset + (target_velocity_v * 100)
	#var future_h_offset = enemy.h_offset * (600 * delta / path_length)
	#var future_v_offset = enemy.v_offset * (600 * delta / path_length)
	
	# Check both offset are inside curve's length
	future_h_offset = wrapf(future_h_offset, 0.0, 1.0) # future_h_offset % path_length
	future_v_offset = wrapf(future_v_offset, 0.0, 1.0)
	#
	var oghoffset = enemy.h_offset
	var ogvoffset = enemy.v_offset
	enemy.h_offset = future_h_offset 
	enemy.v_offset = future_v_offset 
	var future_position = enemy.position
	enemy.h_offset = oghoffset
	enemy.v_offset = ogvoffset
	
	return future_position

func _shoot(target_position, anim, flip_h):
	var direction = (target_position - $Archer.global_position).normalized()
	# 1º Start shoot animation
	#_anim_archer(anim, flip_h)
	# 2º When anim finished intantiate projectile
	if _throw_arrow:
		_throw_arrow = false
		var projectile = Projectile.instantiate()
		projectile.position = to_local($Archer.global_position)
		projectile.rotation = get_angle_to(target_position)
		projectile.velocity = direction * _arrow_speed
		add_child(projectile)
		_anim_archer("idle", _has_to_flip_h(_prev_orientation))

# Gets enemy's orientation
func _get_orientation(enemy, archer) -> String:
	if enemy.x < archer.x and enemy.y > archer.y:
		return "down_left"
	elif enemy.x < archer.x and enemy.y < archer.y:
		return "top_left"
	elif enemy.x > archer.x and enemy.y < archer.y:
		return "top_right"
	elif enemy.x > archer.x and enemy.y > archer.y:
		return "down_right"
	elif enemy.x < archer.x and enemy.y == archer.y:
		return "left"
	elif enemy.x > archer.x and enemy.y == archer.y:
		return "right"
	elif enemy.x == archer.x and enemy.y < archer.y:
		return "top"
	elif enemy.x == archer.x and enemy.y > archer.y:
		return "down"
	return ""

# Get what anim the archer has to play
func _get_archer_anim(orientation: String) -> String:
	match orientation:
		"top_right", "top_left":
			return "shot_top_right"
		"right", "left":
			return "shot_right"
		"down_right", "down_left":
			return "shot_down_right"
		"top":
			return "shot_top"
		"down":
			return "shot_down"
		_:
			return "idle"

# Check if have to flip the archer's animation based on the enemy's orientation
func _has_to_flip_h(orientation: String) -> bool:
	return true if orientation == "top_left" or orientation == "left" or orientation == "down_left" else false

# Anims the tower's archer with the correct animation
func _anim_archer(anim: String, flip_h: bool):
	$Archer.flip_h = flip_h
	$Archer.play(anim)
	
func _play_build_sound():
	if not $BuildSound.playing:
		SoundManager.play_sound($BuildSound)

func _update_tower_interface(upgrade: Label, prize: int):
	upgrade.text = str(prize)

func _update_attack_speed():
	if _can_upgrade(upgrade_attack_speed_prize, _attack_speed_level):
		_update_player_balance(upgrade_attack_speed_prize)
		_attack_speed_level += 1
		upgrade_attack_speed_prize = upgrade_attack_speed_prize * _attack_speed_level
		_update_tower_interface($Improvements/AttackSpeed/Prize, upgrade_attack_speed_prize)
		if $Archer.speed_scale + 0.2 <= 2:
			$Archer.speed_scale += 0.2
			_current_speed = $Archer.speed_scale

func _update_damage():
	if _can_upgrade(upgrade_damage_prize, _damage_level):
		_update_player_balance(upgrade_damage_prize)
		_damage_level += 1
		upgrade_damage_prize = upgrade_damage_prize * _damage_level
		_update_tower_interface($Improvements/Damage/Prize, upgrade_damage_prize)
		_tower_damage += 10

func _can_upgrade(upgrade_prize: int, upgrade_level: int) -> bool:
	return scoreLabel and int(scoreLabel.text) >= upgrade_prize and upgrade_level < UPGRADE_MAX_LEVEL

func _update_player_balance(upgrade_prize: int) -> void:
	var current_balance = int(scoreLabel.text) - upgrade_prize
	GlobalScene.set_gold(current_balance)
	scoreLabel.text = str(GlobalScene.get_gold())

func _update_tower_speed() -> void:
	$Archer.speed_scale = _current_speed if GlobalScene.get_game_speed() == 1 else 2

func _on_body_entered(body):
	if body is RigidBody2D or body is CharacterBody2D or body is StaticBody2D and body.is_in_group("enemy"):
		_objects_inside.append(body)
		#print("Enemy entered the area: ", body.name)
		#print("Enemies inside area: ", _objects_inside.size())

func _on_body_exited(body):
	if body is RigidBody2D or body is CharacterBody2D or body is StaticBody2D and body.is_in_group("enemy"):
		_objects_inside.erase(body)
		#print("Enemy exited the area: ", body.name)
		#print("Enemies outside area: ", _objects_inside.size())
		var orientation = _get_orientation(body.global_position, $Archer.global_position)
		var flip_h = _has_to_flip_h(orientation)
		flipped = flip_h
		_anim_archer("idle", flip_h)

func _on_fire_rate_timeout():
	_play_throw_anim = true

func _on_archer_animation_finished():
	# hurt enemy
	if _objects_inside.size() > 0:
		if _objects_inside[0].has_method("_take_damage"):
			_objects_inside[0]._take_damage(_tower_damage)
			#_throw_arrow = true

func _on_attack_speed_button_down():
	$Improvements/AttackSpeed/ButtonTexture.texture = pressed_attack_speed

func _on_attack_speed_button_up():
	GlobalScene.button_pressed.emit()
	$Improvements/AttackSpeed/ButtonTexture.texture = idle_attack_speed
	_update_attack_speed()

func _on_damage_button_down():
	$Improvements/Damage/ButtonTexture.texture = pressed_increase_attack

func _on_damage_button_up():
	GlobalScene.button_pressed.emit()
	$Improvements/Damage/ButtonTexture.texture = idle_increase_attack
	_update_damage()

func _on_area_exited(area):
	var node = area.get_parent()
	var orientation = _get_orientation(node.global_position, $Archer.global_position)
	var flip_h = _has_to_flip_h(orientation)
	if node.is_in_group("enemy"):
		for enemy in _objects_inside:
			if is_instance_valid(enemy) and enemy.get_instance_id() == node.get_instance_id():
				print(enemy.get_health())
				if enemy.get_health() <= 0:
					_objects_inside.erase(enemy)
			else:
				_objects_inside.erase(enemy)
			flipped = flip_h
	_anim_archer("idle", flip_h)

func _on_tower_vision_area_entered(area):
	var node = area.get_parent()
	if node.is_in_group("enemy") and area.is_in_group("enemyHitbox"):
		for enemy in _objects_inside:
			if is_instance_valid(enemy) and enemy.get_instance_id() == node.get_instance_id():
				return
		_objects_inside.append(node)

func _on_tower_vision_area_exited(area):
	var node = area.get_parent()
	for object in _objects_inside:
		if checkIfObjectInstanceIsValid(node, object):
			if checkIfEnteredNodeIsAnEnemy(node, area):
				if object.has_method("set_aimed"):
					object.set_aimed(false)
				_objects_inside.erase(object)
				var orientation = _get_orientation(node.global_position, $Archer.global_position)
				var flip_h = _has_to_flip_h(orientation)
				flipped = flip_h
				_anim_archer("idle", flip_h)

func checkIfObjectInstanceIsValid(node, object) -> bool:
	return is_instance_valid(object) and object.get_instance_id() == node.get_instance_id()

func checkIfEnteredNodeIsAnEnemy(node, area) -> bool:
	return node.is_in_group("enemy") and area.is_in_group("enemyHitbox")
