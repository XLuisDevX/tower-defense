extends Control

@export var scoreLabel: Label

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
	scoreLabel.text = str(GlobalScene.get_gold())

func _on_game_manager_update_gold():
	$ScoreLabel.text = $ScoreLabel.text + str(10)
