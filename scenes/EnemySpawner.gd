extends Node

var torch_goblin = preload("res://scenes/torch_goblin.tscn")
var tnt_goblin = preload("res://scenes/tnt_goblin.tscn")
var barrel_goblin = preload("res://scenes/barrel_goblin.tscn")
var torch_goblin_boss = preload("res://scenes/torchGoblinBoss.tscn")
var tnt_goblin_boss = preload("res://scenes/tntGoblinBoss.tscn")

var rng = RandomNumberGenerator.new()
#@export var path_follow: PathFollow2D
@export var path2D: Path2D
@export var spawn_timer: Timer
#                       0             1            2
var enemy_types = [torch_goblin, tnt_goblin, barrel_goblin]
var enemy_dic = {
	"0": 10,
	"1": 0,
	"2": 0
}
var enemies_to_spawn = 0
var bosses_to_spawn = 0
var spawn_interval = 1.0
var _drop_percentage: float = 0.0
var enemies_spawned_counter = 0

signal enemy_attacks
signal enemy_dies

func start_wave(wave_data):
	enemies_to_spawn = wave_data.enemy_count
	if wave_data.has("boss_count"):
		bosses_to_spawn = wave_data.boss_count
	spawn_interval = wave_data.spawn_interval
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1
	else:
		_update_enemy_weights(enemy_dic)
		spawn_timer.stop()

func spawn_enemy():
	# Selects diferent types of enemies
	var enemy = _select_enemy().instantiate()
	#var enemy = torch_goblin.instantiate()
	#var enemy = tnt_goblin.instantiate()
	#var enemy = barrel_goblin.instantiate()
	#var enemy = torch_goblin_boss.instantiate()
	#var enemy = tnt_goblin_boss.instantiate()
	#var enemy = torch_goblin_boss.instantiate()
	#var enemy = _select_enemy().instantiate()
	
	#enemy.drops_gold = true #if randf() < 0.5 else false
	enemy.set_drops_gold()
	#SignalBus.attack.connect(Callable(self, "notify_enemy_attacks"))
	#enemy.connect("attack", Callable(self, "notify_enemy_attacks"))
	
	enemy._anim_enemy("walk")
	enemy.add_to_group("enemy")
	print('Enemy is in "enemy" group: ', enemy.is_in_group("enemy"))
	print('Enemy is in "GROUP_TEST" group: ', enemy.is_in_group("GROUP_TEST"))
	var enemy_follow = PathFollow2D.new()
	#enemy_follow.add_to_group("enemy")
	enemy_follow.rotates = false
	enemy_follow.loop = false
	path2D.add_child(enemy_follow)
	enemy_follow.h_offset = rng.randf_range(-75.0, 50.0) # Random position on the path
	enemy_follow.v_offset = rng.randf_range(-50.0, 40.0)
	enemy_follow.add_child(enemy)
	
	enemies_spawned_counter += 1

func notify_enemy_attacks(damage):
	enemy_attacks.emit()

func notify_game_over():
	var enemies_path_follow = get_enemies_path_follow(path2D.get_children())
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
	if bosses_to_spawn > 0:
		bosses_to_spawn -= 1
		return torch_goblin_boss
	else:
		#TODO: System of weights that the more easily enemies appears more on low rounds
		var enemy_index = int(_choose_enemy_by_weight(enemy_dic))
		return enemy_types[enemy_index]

func _choose_enemy_by_weight(enemies: Dictionary):
	var total_weight = 0.0
	for weight in enemies.values():
		total_weight += weight
	
	var rnd_value = randf() * total_weight
	var acc_weight = 0.0
	
	for enemy in enemies.keys():
		acc_weight += enemies[enemy]
		if rnd_value <= acc_weight:
			return enemy
	return ""
	
func _update_enemy_weights(enemies: Dictionary):
	for enemy in enemies.keys():
		if enemies[enemy] < 10.0:
			enemies[enemy] += 0.025
			
	

func _process(delta):
	if enemies_spawned_counter != get_tree().get_nodes_in_group("enemy").size():
		enemies_spawned_counter = get_tree().get_nodes_in_group("enemy").size()
		enemy_dies.emit()
