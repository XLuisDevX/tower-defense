extends Control

var _roundCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	increment_round_count()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func increment_round_count() -> void:
	_roundCount += 1
	_update_round_info()
	
func _update_round_info() -> void:
	$Label.text = $Label.text + str(_roundCount)
