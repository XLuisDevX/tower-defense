extends Enemy

#@export var gold_scene = preload("res://scenes/gold_bag.tscn")
#var health = 40 # Life points will increment during rounds to enemies more difficul to be defeated

var previous_position

func _init():
	call_deferred("_post_init")
	super(40, 10, 100)
	
func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
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

#func anim_enemy(anim: StringName):
	#$AnimatedSprite2D.play(anim)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		_anim_enemy("attack") if !is_game_over else _anim_enemy("idle")
		speed = 0 # stops enemy

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		attack.emit()
		
func set_aimed(aimed: bool):
	#aimed = true
	$Marker.visible = aimed
