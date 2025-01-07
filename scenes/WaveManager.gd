extends Node

@export var enemySpawner: Node
@export var UI_roundInfo: Control
@export var UI_countdown: Label

signal wave_started(wave_number)
signal wave_completed(wave_number)

var current_wave = 0
var waves = [
	{"enemy_count": 5, "spawn_interval": 2.0},
	{"enemy_count": 10, "spawn_interval": 0.8},
	{"enemy_count": 15, "spawn_interval": 0.6}
]

var enemies_defeated = 0
var time_left = 6

@onready var enemy_spawner = $"../EnemySpawner"
@onready var wave_timer = $WaveTimer

func _ready():
	UI_countdown.text = str(time_left)
	wave_timer.wait_time = 1
	enemySpawner.connect("enemy_dies", Callable(self, "on_enemy_defeated"))
	wave_timer.connect("timeout", Callable(self, "start_next_wave"))
	
	if UI_countdown:
		print("Nodo asignado desde el editor:", UI_countdown.name)
	else:
		print("El nodo asignado está vacío o no está en el árbol.")
	
	wave_timer.start()
	start_game()

func start_game():
	start_next_wave()

func start_next_wave():
	time_left -= 1
	if time_left <= 5 and time_left > 0:
		UI_countdown.visible = true
		UI_countdown.text = str(time_left)
	else:
		UI_countdown.visible = false
	var tween = create_tween()
	UI_countdown.modulate = Color(1.0, 0.8, 0.5)
	UI_countdown.get_child(0).play("mystic_pulse")
	if time_left <= 0:
		wave_timer.stop()
		UI_roundInfo.increment_round_count()
		if current_wave < waves.size():
			current_wave += 1
			GlobalScene.set_wave_index(current_wave)
			var wave_data = waves[current_wave - 1]
			enemy_spawner.start_wave(wave_data["enemy_count"], wave_data["spawn_interval"])
			enemies_defeated = 0
			emit_signal("wave_started", current_wave)
		else:
			print("All waves completed!")

func on_enemy_defeated():
	enemies_defeated += 1
	if enemies_defeated == waves[current_wave - 1]["enemy_count"]:
		on_wave_completed()

func on_wave_completed():
	emit_signal("wave_completed", current_wave)
	wave_timer.start(5)  # 5-second delay before next wave
