extends CharacterBody2D
class_name Enemy

@onready var gameNode = $"."

var gold_scene = preload("res://scenes/gold_bag.tscn")
var game_scene = preload("res://scenes/game.tscn")
var aimed = false
var drops_gold = false
var gold_rate = 1.00
var decrement_factor = 0.025

var health
var score
var speed
var previousPos
var sprite
var current_progress = 0.0
var path_follow_instance = null
var _LINEAL_LIFE_INCREMENT = 5
var _PERCENTAGE_INCREMENT = 1.05
var MAX_HEALT = 500 # Adjust by balance

var is_game_over = false # if true stop attacking and play idle anim
var reach_player = false # if false when is game over still playing walk anim until reach player castle

signal attack

#region SETTERS AND GETTERS
func set_health(hp) -> void:
	health = hp
	
func get_health() -> int:
	return health
	
func set_score(sc) -> void:
	score = sc
	
func get_score() -> int:
	return score

func set_speed(sp) -> void:
	speed = sp * GlobalScene.get_game_speed()
	
func get_speed() -> int:
	return speed
	
func set_sprite(sprite_) -> void:
	sprite = sprite_
	
func get_sprite() -> int:
	return sprite
	
func set_previous_position(prevPos) -> void:
	previousPos = prevPos
	
func get_previous_position() -> Vector2:
	return previousPos

func set_aimed(aimed: bool) -> void:
	aimed = true

func _get_aimed() -> bool:
	return aimed

#endregion SETTERS AND GETTERS

func _init(hp, sc, sp) -> void:
	health = _calculate_health(hp)
	score = sc
	speed = sp * GlobalScene.get_game_speed()
	
	GlobalScene.connect("game_speed_updated", Callable(self, "update_enemy_speed"))

# Calculates enemy's life based on current wave
func _calculate_health(hp):
	var health = hp + (GlobalScene.get_wave_index() * _LINEAL_LIFE_INCREMENT)
	health *= pow(_PERCENTAGE_INCREMENT,GlobalScene.get_wave_index())
	print('ENEMY LIFE: ', int(min(health, MAX_HEALT)))
	return int(min(health, MAX_HEALT))
	
func _update_unset_properties(prevPos: Vector2, _sprite: AnimatedSprite2D) -> void:
	previousPos = prevPos
	sprite = _sprite

func _physics_process(delta):
	_check_offset(delta)
	_check_direction()

# Checks if enemy reachs player to reset h_offset so enemy hits the player instead staying
# to far from player or above the player.
func _check_offset(delta) -> void:
	var path_follow = get_parent() as PathFollow2D
	if path_follow:
		path_follow.progress += speed * delta
		if path_follow.progress_ratio >= 1.0:
			path_follow.h_offset = 0
	#path_follow.h_offset = 0
	# TODO: Detect collision with player by collision shape
	#if path_follow.progress_ratio > 0.98 && roundf(path_follow.progress_ratio) >= 1.0:
		#print(path_follow.progress_ratio)
		#path_follow.h_offset = 0

func _check_direction() -> void:
	#var currentPos = get_parent().global_position
	var currentPos = global_position
	var flip_h = roundf(currentPos.x - previousPos.x) < 0
	sprite.flip_h = flip_h
	#previousPos = get_parent().global_position
	previousPos = global_position

func set_drops_gold() -> void:
	var new_gold_rate = gold_rate - (decrement_factor * (GlobalScene.get_wave_index() - 1))
	if new_gold_rate > 0.35:
		new_gold_rate = 0.35
	#TODO: Check if it's normal enemy or a boss.
	# - If it's a boss -> Always drops gold
	if self.is_in_group("BOSS"):
		drops_gold = true
	else:
		# - If it's a normal enemy -> It could drop gold or not
		drops_gold = chance(new_gold_rate)
		
func chance(percent: float) -> bool:
	var probability = percent
	if probability > 1:
		probability = percent / 100
	var rnd = randf()
	
	return rnd < probability

func _take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		if drops_gold: _drop_gold()
		_update_score()
		if get_parent() is PathFollow2D:
			get_parent().queue_free()
		queue_free()

func _drop_gold() -> void:
	var gold_bag = gold_scene.instantiate() # Instantiates gold_scene
	var mainNode = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	mainNode.add_child(gold_bag)
	#get_parent().add_child(gold_bag)
	#get_tree().root.add_child(gold_bag) # Add gold_scene instance into main node
	gold_bag.position = global_position # Update instance position after been added to main node

func _update_score():
	GlobalScene.set_score(GlobalScene.get_score() + score * GlobalScene.get_wave_index())

func _reset_h_offset():
	var path_follow = get_parent() as PathFollow2D
	path_follow.h_offset = 0

func _anim_enemy(anim: String) -> void:
	$AnimatedSprite2D.play(anim)

func exit_path_follow() -> void:
	var world_position = global_position
	
	path_follow_instance = get_parent()
	var main_scene = get_tree()
	get_parent().remove_child(self)
	main_scene.current_scene.add_child(self)
	set_deferred("global_position", world_position)
	
	path_follow_instance.progress += 300
	current_progress = path_follow_instance.progress
	
	call_deferred("_check_direction")

func return_to_path_follow(delta):
	global_position = global_position.move_toward(path_follow_instance.position, 75 * delta)

func update_enemy_speed():
	var game_speed = GlobalScene.get_game_speed()
	speed = speed / 2 if game_speed == 1 else speed * 2
