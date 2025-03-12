extends Enemy

var _HEALTH = 40
var _SCORE = 10
var _SPEED = 500


func _init():
	call_deferred("_post_init")
	super(_HEALTH, _SCORE, _SPEED)
	
func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)

func set_aimed(aimed: bool):
	#aimed = true
	$Marker.visible = aimed

func _check_offset(delta) -> void:
	var path_follow = get_parent() as PathFollow2D
	path_follow.progress += speed * delta
	if path_follow.progress >= 1.0:
		path_follow.h_offset = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		if !is_game_over:
			_anim_enemy("charging")
			var charging_timer = Timer.new()
			charging_timer.wait_time = 2
			charging_timer.one_shot = true
			add_child(charging_timer)
			charging_timer.start()
			charging_timer.timeout.connect(Callable(self, "on_charging_timer_timeout"))
		else:
			_anim_enemy("idle")
		speed = 0 # stops enemy

func on_charging_timer_timeout():
	SignalBus.attack.emit(100)
	_anim_enemy("explode")

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "walk":
		speed = _SPEED


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 4:
		speed = 0


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "explode":
		queue_free()
