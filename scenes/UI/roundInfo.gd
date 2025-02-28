extends Control

var _roundCount = 0
var _originalColor = Color(0,0,0)
var _bossColor = Color(1,0,0)
var _original_size
var min_font_size = 48
var max_font_size = 60

var _ROUND_ANIMATIONS = {
	"idle": "idle",
	"incomming": "incomming",
	"passed": "passed"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#increment_round_count()
	_original_size = $RoundText.get_minimum_size().x
	$BossInfo.play(_ROUND_ANIMATIONS.idle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func increment_round_count() -> void:
	_roundCount += 1
	if (_roundCount + 1) % 5 == 0:
		_show_boss_info()
	elif (_roundCount - 1) % 5 == 0:
		_hide_boss_info()
	elif _roundCount % 5 == 0:
		$RoundText.add_theme_color_override("font_color", _bossColor)
	else:
		$RoundText.add_theme_color_override("font_color", _originalColor)
	_update_round_info()
	
func _update_round_info() -> void:
	$RoundText.text = "Round: " + str(_roundCount)
	var font_size_factor = (($RoundText.get_minimum_size().x - _original_size) / _original_size) * (max_font_size - min_font_size)
	var new_font_size = max_font_size - font_size_factor
	$RoundText.add_theme_font_size_override("font_size", new_font_size)

func _show_boss_info():
	$BossInfo.play(_ROUND_ANIMATIONS.incomming)

func _hide_boss_info():
	if $BossInfo.is_playing() and $BossInfo.animation == _ROUND_ANIMATIONS.incomming:
		$BossInfo.frame = $BossInfo.sprite_frames.get_frame_count()
		$BossInfo.play(_ROUND_ANIMATIONS.passed)
	
