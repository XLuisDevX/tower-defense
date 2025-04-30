extends Node

var _buttonFx: AudioStreamPlayer
var _collect_goldFx: AudioStreamPlayer
var recently_played_sounds = []
var crossfade_time = 5

class sound_info:
	var timer
	var resource_path

func _ready():
	createButtonSound()
	attachEvents()
	
func _process(delta):
	for i in range(recently_played_sounds.size() - 1, -1, -1):
		recently_played_sounds[i].timer -= delta
		if recently_played_sounds[i].timer <= 0.0:
			recently_played_sounds.remove_at(i)

#region UTILS
func play_sound(sound: AudioStreamPlayer):
	if not sound.playing:
		sound.play()

func play_collect_sound(sound: AudioStreamPlayer):
	if not sound_was_already_played(sound.stream):
		register_sound(sound.stream)
		sound.play()

func register_sound(_stream, _timer = 0.03):
	var new_sound_info = sound_info.new()
	new_sound_info.resource_path = _stream.resource_path
	new_sound_info.timer = _timer
	recently_played_sounds.append(new_sound_info)

func sound_was_already_played(_stream):
	for my_sound in recently_played_sounds:
		if _stream.resource_path == my_sound.resource_path:
			return true
	return false
	
func start_crossfade_to_boss(from_sound: AudioStreamPlayer, to_sound: AudioStreamPlayer):
	to_sound.play()
	_crossfade(from_sound, to_sound)

func start_crossfade_to_normal(from_sound: AudioStreamPlayer, to_sound: AudioStreamPlayer):
	to_sound.play()
	_crossfade(from_sound, to_sound)

func _crossfade(from_sound: AudioStreamPlayer, to_sound: AudioStreamPlayer):
	var steps = 30
	var delay = crossfade_time / steps
	
	for i in range(steps + 1):
		var t = i / float(steps)
		var eased = t * t * (3.0 - 2.0 * t)
		from_sound.volume_db = lerp(0.0, -80.0, eased)
		to_sound.volume_db = lerp(-80.0, 0.0, eased)
		await get_tree().create_timer(delay).timeout
	from_sound.stop()
	
func _fade_out_background(background: AudioStreamPlayer):
	var steps = 30
	var delay = crossfade_time / steps
	for i in range(steps + 1):
		var t = i / float(steps)
		var eased = t * t * (3.0 - 2.0 * t)
		background.volume_db = lerp(0.0, -80.0, eased)

func _fade_in_background(background: AudioStreamPlayer):
	var steps = 30
	var delay = crossfade_time / steps
	for i in range(steps + 1):
		var t = i / float(steps)
		var eased = t * t * (3.0 - 2.0 * t)
		background.volume_db = lerp(-80.0, 0.0, eased)
#endregion

#region EVENTS
func attachEvents():
	GlobalScene.button_pressed.connect(Callable(self,"on_button_pressed"))

func on_button_pressed():
	if not _buttonFx.playing:
		_buttonFx.play()
#endregion

#region CREATE
func createButtonSound():
	_buttonFx = AudioStreamPlayer.new()
	_buttonFx.stream = load("res://assets/sounds/ButtonPressed.mp3")
	_buttonFx.autoplay = false
	add_child(_buttonFx)
#endregion

