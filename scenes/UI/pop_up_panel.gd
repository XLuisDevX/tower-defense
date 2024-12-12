extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("pop_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_anim(anim: String) -> void:
	visible = true
	$AnimationPlayer.play("pop_up")
