extends Node

var torch_goblin = preload("res://scenes/torch_goblin.tscn")
var tnt_goblin = preload("res://scenes/tnt_goblin.tscn")
var barrel_goblin = preload("res://scenes/barrel_goblin.tscn")
var torch_goblin_boss = preload("res://scenes/torchGoblinBoss.tscn")
var tnt_goblin_boss = preload("res://scenes/tntGoblinBoss.tscn")

var rng = RandomNumberGenerator.new()
@export var path_follow: PathFollow2D
@export var spawn_timer: Timer

var enemy_types = [torch_goblin, tnt_goblin, barrel_goblin]
var enemies_to_spawn = 0
var spawn_interval = 1.0
var _drop_percentage: float = 0.0
var enemies_spawned_counter = 0

signal enemy_attacks
signal enemy_dies

func start_wave(enemy_count, interval):
	enemies_to_spawn = enemy_count
	spawn_interval = interval
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1
	else:
		spawn_timer.stop()

func spawn_enemy():
	# Selects diferent types of enemies
	#var enemy = _select_enemy().instantiate()
	var enemy = torch_goblin.instantiate()
	#var enemy = tnt_goblin.instantiate()
	#var enemy = torch_goblin_boss.instantiate()
	#var enemy = tnt_goblin_boss.instantiate()
	#var enemy = torch_goblin_boss.instantiate()
	#var enemy = _select_enemy().instantiate()
	
	#enemy.drops_gold = true #if randf() < 0.5 else false
	enemy.set_drops_gold()
	#SignalBus.attack.connect(Callable(self, "notify_enemy_attacks"))
	#enemy.connect("attack", Callable(self, "notify_enemy_attacks"))
	
	enemy._anim_enemy("walk")
	var enemy_follow = PathFollow2D.new()
	enemy_follow.add_to_group("enemy")
	enemy_follow.rotates = false
	enemy_follow.loop = false
	path_follow.get_parent().add_child(enemy_follow)
	enemy_follow.h_offset = rng.randf_range(-75.0, 50.0) # Random position on the path
	enemy_follow.v_offset = rng.randf_range(-50.0, 40.0)
	enemy_follow.add_child(enemy)
	
	enemies_spawned_counter += 1

func notify_enemy_attacks(damage):
	enemy_attacks.emit()

func notify_game_over():
	var enemies_path_follow = get_enemies_path_follow(path_follow.get_parent().get_children())
	for enemy_index in range(0, enemies_path_follow.size()):
		var enemy = enemies_path_follow[enemy_index].get_child(0)
		enemy.is_game_over = true
		var anim = "idle" if enemy.reach_player else "walk"
		enemy._anim_enemy(anim)
	
func get_enemies_path_follow(array: Array[Node]):
	var enemy_instancies = []
	for index in range(0, array.size()):
		if array[index].is_in_group("enemy"):
			enemy_instancies.append(array[index])
	return enemy_instancies

func _select_enemy():
	var rnd = randf()
	if rnd < 0.25: return enemy_types[0]
	elif rnd >= 0.25 and rnd < 0.75: return enemy_types[1]
	else: return enemy_types[2]

func _process(delta):
	if enemies_spawned_counter != get_enemies_path_follow(path_follow.get_parent().get_children()).size():
		enemies_spawned_counter = get_enemies_path_follow(path_follow.get_parent().get_children()).size()
		enemy_dies.emit()
