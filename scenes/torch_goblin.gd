extends Enemy

#@export var gold_scene = preload("res://scenes/gold_bag.tscn")
#var health = 40 # Life points will increment during rounds to enemies more difficul to be defeated

var previous_position

func _init():
	call_deferred("_post_init")
	#print(get_parent().global_position)
	super(40, 10, 100)
	
func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
#func _ready():
	##set_health(40)
	##set_score(10)
	##set_speed(100)
	##set_previous_position(get_parent().global_position)
	##set_sprite($AnimatedSprite2D)
	##_gameManager = game_manager_scene.instantiate()
	##previous_position = get_parent().global_position
	#
	
#func _physics_process(delta):
	#_check_offset(delta)
	#_check_direction()
	
# Checks if enemy reachs player to reset h_offset so enemy hits the player instead staying
# to far from player or above the player.
#func _check_offset(delta):
	#var path_follow = get_parent() as PathFollow2D
	#_check_offset_main_class(path_follow, speed, delta)
	##path_follow.progress += speed * delta
	##if path_follow.progress >= 1.0:
		##path_follow.h_offset = 0
	
# Check if the enemy is moving right or left to flip the sprite.
#func _check_direction():
	##var current_pos = get_parent().global_position
	#_check_direction_main_class(get_parent().global_position, previous_position, $AnimatedSprite2D)
	##var flip_h = roundf(current_pos.x - previous_position.x) < 0
	#previous_position = get_parent().global_position
	##$AnimatedSprite2D.flip_h = flip_h
#
#func _take_damage(amount):
	#super(amount)
	##_take_damage_main_class(amount)
	###health -= amount
	##if get_health() <= 0:
		### Update score on screen
		##_update_score()
		##
		###if drops_gold: _drop_gold()
		###get_parent().queue_free()
		###queue_free()

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
	#aimed = true
	$Marker.visible = aimed
	
#func _drop_gold():
	##var gold_bag = gold_scene.instantiate()
	##gold_bag.position = get_parent().position
	###gold_bag.connect("collect_gold", Callable(game_manger, "notify_collect_gold"))
	##get_parent().get_parent().add_child(gold_bag)
	#pass

#func _update_score():
	#GlobalScene.set_score(GlobalScene.get_score() + enemy_score * GlobalScene.get_wave_index())
