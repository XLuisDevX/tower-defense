extends Enemy


func _init():
	call_deferred("_post_init")
	super(40, 10, 100) # (health, damage, speed)
	
func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)

func set_aimed(aimed: bool):
	#aimed = true
	$Marker.visible = aimed


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
