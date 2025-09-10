extends Control

var _alert_pawns = false
var _hidden_pawns_counter = 0

signal settings_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$Settings.visible = false
	$PlayButton.connect("play_pressed", Callable(self, "animate_pawns"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _alert_pawns:
		var pawns_array = get_tree().get_nodes_in_group("pawn_path")
		_set_pawns_to_hide(pawns_array, delta)
		#$StartGameTimer.start(10)
func timer_Timeout():
	_start_game()
		
func animate_pawns():
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 4
	timer.start()
	timer.timeout.connect(timer_Timeout)
	
	_alert_pawns = true
	
func _set_pawns_to_hide(pawns_array, delta):
	for pawn in pawns_array:
		var sprite: AnimatedSprite2D = pawn.get_children()[0].get_node("AnimatedSprite2D")
		var path_follow: PathFollow2D = pawn.get_children()[0]
		if sprite.visible != false:
			sprite.play("run")
			if sprite.flip_h:
				sprite.flip_h = false
					
			var speed_factor = 1
			var max_speed = 800
			var min_speed = 100
			var distance = round(pawn.get_curve().get_baked_length())
			var dynamic_speed = clamp(distance * speed_factor, min_speed, max_speed)
			path_follow.progress += dynamic_speed * delta
			if path_follow.progress_ratio >= 1.0:
				path_follow.progress_ratio = 0
				sprite.visible = false
					#sprite.queue_free()
					#_hidden_pawns_counter += 1
					#sprite.visible = false
						#get_tree().change_scene_to_file("res://scenes/game.tscn")
						#SceneSwitcher.switch_scene("res://scenes/game.tscn")
			
func _start_game():
	SceneSwitcher.switch_scene("res://scenes/game.tscn")
