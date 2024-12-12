extends StaticBody2D


signal collect_gold

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and !event.pressed:
		collect_gold.emit()
		queue_free()
		GlobalScene.set_gold(GlobalScene.get_gold()+10)
		print('click en instancia')
