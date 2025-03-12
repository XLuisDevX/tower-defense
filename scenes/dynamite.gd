extends Area2D

var velocity = Vector2.ZERO
var alive = false

func _ready():
	gravity = 300
	var speed = 300
	var angle = deg_to_rad(-50)
	
	velocity.x = cos(angle) * speed
	velocity.y = sin(angle) * speed
	
	alive = true

func _process(delta):
	if alive:
		rotate(deg_to_rad(5))
		velocity.y += gravity * delta
		global_position += velocity * delta
	

func move_to_player(delta):
	global_position.x += global_position.x * delta * 0.02
	print(global_position)


func _on_body_entered(body):
	if body.is_in_group("player"):
		alive = false
		# Emit signal to damage player
		get_parent().emit_attack_signal()
		$AnimatedSprite2D.play("explode")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "explode":
		queue_free()
