extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_timer_timeout():
	$AnimatedSprite2D.play("flip")
	$AnimationTimer.stop()


func _on_animated_sprite_2d_animation_finished():
	$AnimationTimer.start()
	
func update_gold():
	print($ScoreValue.text)
	$ScoreValue.text = $ScoreValue.text + str(10)
