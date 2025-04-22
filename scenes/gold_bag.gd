extends StaticBody2D


signal collect_gold

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_sound($DropSound)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and !event.pressed:
		collect_gold.emit()
		#GlobalScene.collect_gold.emit()
		SoundManager.play_collect_sound($CollectSound)
		visible = false
		#$CollectSound.play()
		#queue_free()
		GlobalScene.set_gold(GlobalScene.get_gold()+10)
		#call_deferred("queue_free")


func _on_collect_sound_finished():
	queue_free()
