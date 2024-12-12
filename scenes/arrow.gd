extends Area2D

@export var speed: float = 200

var _damage: int = 20 # Arrow's damage will be incremented by upgrades the player can buy
var velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(20)
		
