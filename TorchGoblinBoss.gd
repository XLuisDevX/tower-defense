extends Enemy

var is_tower = false
var has_target = false

func _init():
	call_deferred("_post_init")
	
	super(200, 100, 75)

func _post_init():
	#$IgniteTimer.start()
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
	
func _physics_process(delta):
	if !is_tower: _check_offset(delta)
	_check_direction()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		_anim_enemy("attack") if !is_game_over else _anim_enemy("idle")
		speed = 0 # stops enemy
	elif body.is_in_group("tower"):
		print(body.name)

func _on_boss_sprite_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		attack.emit()

func set_aimed(aimed: bool):
	$Marker.visible = aimed

func _on_area_2d_area_entered(area):
	if area.is_in_group("tower") and !has_target:
		has_target = true
		$IgniteTimer.start()
		#ignite_timer.start()


func _on_ignite_timer_timeout():
	is_tower = true
	$AnimatedSprite2D.play("ignite")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "ignite":
		$AnimatedSprite2D.play("walk")
		is_tower = false
