extends CharacterBody2D

@export var gold_scene = preload("res://scenes/gold_bag.tscn")
var waveManager = preload("res://scenes/WaveManager.gd")
var game_manger = load("res://scenes/game_manager.tscn").instantiate()

var speed = 100
var health = 40 # Life points will increment during rounds to enemies more difficul to be defeated
var aimed = false
var drops_gold = false

var is_game_over = false # if true stop attacking and play idle anim
var reach_player = false # if false when is game over still playing walk anim until reach player castle
var _gameManagerScript

var previous_position

var originalX = -INF
var originalY = -INF

signal attack

func _ready():
	#_gameManager = game_manager_scene.instantiate()
	previous_position = get_parent().global_position
	print(get_parent().global_position)
	_gameManagerScript = game_manger.get_script()
	
func _physics_process(delta):
	_check_offset(delta)
	_check_direction()
	
# Checks if enemy reachs player to reset h_offset so enemy hits the player instead staying
# to far from player or above the player.
func _check_offset(delta):
	var path_follow = get_parent() as PathFollow2D
	path_follow.progress += speed * delta
	if path_follow.progress >= 1.0:
		path_follow.h_offset = 0
	
# Check if the enemy is moving right or left to flip the sprite.
func _check_direction():
	var current_pos = get_parent().global_position
	var next_pos = current_pos + get_parent().transform.x
	
	var flip_h = roundf(current_pos.x - previous_position.x) < 0
	previous_position = current_pos
	$AnimatedSprite2D.flip_h = flip_h

func take_damage(amount):
	health -= amount
	if health <= 0:
		if drops_gold: _drop_gold()
		get_parent().queue_free()
		#queue_free()

func anim_enemy(anim: StringName):
	$AnimatedSprite2D.play(anim)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		anim_enemy("attack") if !is_game_over else anim_enemy("idle")
		speed = 0 # stops enemy

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		attack.emit()
		
func set_aimed(aimed: bool):
	aimed = true
	$Marker.visible = aimed
	
func _drop_gold():
	var gold_bag = gold_scene.instantiate()
	gold_bag.position = get_parent().position
	#gold_bag.connect("collect_gold", Callable(game_manger, "notify_collect_gold"))
	get_parent().get_parent().add_child(gold_bag)
