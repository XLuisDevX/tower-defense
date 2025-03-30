extends Node

var _buttonFx: AudioStreamPlayer

func _ready():
	createButtonSound()
	attachEvents()

#region UTILS
func play_sound(sound: AudioStreamPlayer):
	sound.play()
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

