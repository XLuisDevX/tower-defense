extends Enemy

var dynamite_scene = preload("res://scenes/dynamite.tscn")
var _attack_timer

var _HEALTH = 32 # Life points will increment during rounds to enemies more difficul to be defeated
var _SCORE = 10
var _SPEED = 100
var _DAMAGE = 20

func _init():
	call_deferred("_post_init")
	super(_HEALTH, _SPEED, 200) # (health, damage, speed)
	
func _post_init():
	_update_unset_properties(get_parent().global_position, $AnimatedSprite2D)
	_attack_timer = _create_timer(2, true)

func _create_timer(wait_time: int, one_shot: bool = true) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.one_shot = one_shot
	add_child(timer)
	return timer

func set_aimed(aimed: bool):
	#aimed = true
	$Marker.visible = aimed

func emit_attack_signal():
	SignalBus.attack.emit(_DAMAGE)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		_anim_enemy("attack") if !is_game_over else _anim_enemy("idle")
		speed = 0 # stops enemy

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame == 3 and $AnimatedSprite2D.animation == "attack":
		var dynamite = dynamite_scene.instantiate()
		add_child(dynamite)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		_anim_enemy("idle")
		_attack_timer.start()
		_attack_timer.timeout.connect(Callable(self, "on_attack_timeout"))

func on_attack_timeout():
	_anim_enemy("attack")
