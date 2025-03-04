extends AnimatedSprite2D

var velocity = Vector2.ZERO
var gravity = 300.0

func _ready():
	var speed = 300
	var angle = deg_to_rad(-50)
	
	velocity.x = cos(angle) * speed
	velocity.y = sin(angle) * speed

func _process(delta):
	#move_to_player(delta)
	velocity.y += gravity * delta
	global_position += velocity * delta

func move_to_player(delta):
	global_position.x += global_position.x * delta * 0.02
	print(global_position)
