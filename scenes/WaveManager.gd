extends Node

@export var enemySpawner: Node
@export var UI_roundInfo: Control
@export var UI_countdown: Label
@export var backgroundMusicPlayer: AudioStreamPlayer
@export var bossMusicPlayer: AudioStreamPlayer

signal wave_started(wave_number)
signal wave_completed(wave_number)

var current_wave = 0
var init_wave_enemies = 5
var current_wave_data = {}
var wave_increment = 1.75
var growth_factor = 1
var init_spawn_interval = 2

var enemies_defeated = 0
var time_to_wait = 6
var time_left = time_to_wait
var start_color = Color(0,0,0)
var end_color = Color(1,0,0)
var mainMusic = load("res://assets/sounds/GameBkgMusic.mp3")
var bossMusic = load("res://assets/sounds/BossMusic.mp3")

@onready var enemy_spawner = $"../EnemySpawner"
@onready var wave_timer = $WaveTimer

func _ready():
	backgroundMusicPlayer.play()
	UI_countdown.text = str(time_left)
	UI_countdown.modulate = start_color
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
	if time_left == 3:
		SoundManager.play_sound($CountdownSound)
	
	if time_left <= 5 and time_left > 0:
		UI_countdown.visible = true
		UI_countdown.text = str(time_left)
	else:
		UI_countdown.visible = false
	var tween = create_tween()
	update_color()
	UI_countdown.get_child(0).play("mystic_pulse")
	if time_left <= 0:
		UI_countdown.modulate = end_color
		wave_timer.stop()
		UI_roundInfo.increment_round_count()
		
		current_wave_data = _generate_wave(current_wave)
		current_wave += 1
		GlobalScene.set_wave_index(current_wave)
		print("Enemies to spawn: ", current_wave_data["enemy_count"])
		#enemy_spawner.start_wave(current_wave_data["enemy_count"], current_wave_data["spawn_interval"])
		enemy_spawner.start_wave(current_wave_data)
		enemies_defeated = 0
		emit_signal("wave_started", current_wave)
		#if current_wave < waves.size():
			#current_wave += 1
			#GlobalScene.set_wave_index(current_wave)
			#var wave_data = waves[current_wave - 1]
			#enemy_spawner.start_wave(wave_data["enemy_count"], wave_data["spawn_interval"])
			#enemies_defeated = 0
			#emit_signal("wave_started", current_wave)
		#else:
			#print("All waves completed!")

# TODO: Generate special waves when it has a boss
func _generate_wave(wave_index) -> Dictionary:
	var wave
	var spawnInterval = max(0.5, init_spawn_interval - (wave_index * 0.1))
	if _is_boss_wave(wave_index + 1):
		#SoundManager.fade_inout(backgroundMusic, bossMusic)
		#backgroundMusic.stream = bossMusic
		#backgroundMusic.play()
		SoundManager.start_crossfade_to_boss(backgroundMusicPlayer, bossMusicPlayer)
		# Generate wave with boss
		wave = {"enemy_count": 1, "boss_count": 1, "spawn_interval": spawnInterval }
	else:
		# Generate normal wave
		var numEnemies = int(init_wave_enemies + (wave_index * wave_increment) * (growth_factor ** wave_index))
		wave = {"enemy_count": numEnemies, "spawn_interval": spawnInterval}
		#if backgroundMusic.stream != mainMusic:
			#backgroundMusic.stream = mainMusic
		#if not backgroundMusic.playing and backgroundMusic.stream == mainMusic:
			#backgroundMusic.play()
		if not backgroundMusicPlayer.playing:
			SoundManager.start_crossfade_to_normal(bossMusicPlayer, backgroundMusicPlayer)
	return wave
	
func _is_boss_wave(wave_index) -> bool:
	return wave_index % 5 == 0

func update_color():
	var factor = 1.0 - float(time_left) / float(time_to_wait)
	UI_countdown.modulate = start_color.lerp(end_color, factor)

func on_enemy_defeated():
	enemies_defeated += 1
	if enemies_defeated == current_wave_data["enemy_count"]:
		if current_wave_data.has("boss_count"):
			SoundManager.play_sound($LevelCompleted)
			SoundManager._fade_out_background(bossMusicPlayer)
		on_wave_completed()

func on_wave_completed():
	emit_signal("wave_completed", current_wave)
	wave_timer.start()  # 5-second delay before next wave
	#SoundManager.play_sound($CountdownSound)
	time_left = time_to_wait
	
func _on_level_completed_finished():
	SoundManager._fade_in_background(bossMusicPlayer)
