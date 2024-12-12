extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_anim(anim: String):
	visible = true
	$Banner/AnimPlayer.play("pop_up")


func _on_retry_button_button_up():
	get_tree().reload_current_scene()


func _on_anim_player_animation_finished(anim_name):
	$RetryButton.visible = true
