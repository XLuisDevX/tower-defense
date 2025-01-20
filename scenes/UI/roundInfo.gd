extends Control

var _roundCount = 0
var _originalColor = Color(0,0,0)
var _bossColor = Color(1,0,0)

var _ROUND_ANIMATIONS = {
	"idle": "idle",
	"incomming": "incomming",
	"passed": "passed"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#increment_round_count()
	$BossInfo.play(_ROUND_ANIMATIONS.incomming)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func increment_round_count() -> void:
	_roundCount += 1
	if _roundCount + 1 % 5 == 0:
		_show_boss_info()
	elif _roundCount % 5 == 0:
		$RoundText.add_theme_color_override("font_color", _bossColor)
	else:
		$RoundText.add_theme_color_override("font_color", _originalColor)
	_update_round_info()
	
func _update_round_info() -> void:
	$RoundText.text = "Round: " + str(_roundCount)

func _show_boss_info():
	$BossInfo.play(_ROUND_ANIMATIONS.incomming)

func _hide_boss_info():
	$BossInfo.play(_ROUND_ANIMATIONS.passed)
	
