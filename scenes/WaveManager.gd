extends Node

@export var enemySpawner: Node
@export var UI_roundInfo: Control

signal wave_started(wave_number)
signal wave_completed(wave_number)

var current_wave = 0
var waves = [
	{"enemy_count": 5, "spawn_interval": 2.0},
	{"enemy_count": 10, "spawn_interval": 0.8},
	{"enemy_count": 15, "spawn_interval": 0.6}
]

var enemies_defeated = 0

@onready var enemy_spawner = $"../EnemySpawner"
@onready var wave_timer = $WaveTimer

func _ready():
	enemySpawner.connect("enemy_dies", Callable(self, "on_enemy_defeated"))
	
	wave_timer.connect("timeout", Callable(self, "start_next_wave"))
	start_game()

func start_game():
	start_next_wave()

func start_next_wave():
	wave_timer.stop()
	UI_roundInfo.increment_round_count()
	if current_wave < waves.size():
		current_wave += 1
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
