extends Node


var enemy_scene = preload("res://scenes/torch_goblin.tscn")
var rng = RandomNumberGenerator.new()
@export var path_follow: PathFollow2D
@export var spawn_timer: Timer

var enemies_to_spawn = 0
var spawn_interval = 1.0
var _drop_percentage: float = 0.0

signal enemy_attacks

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
	var enemy = enemy_scene.instantiate()
	
	enemy.drops_gold = true #if randf() < 0.5 else false
	
	enemy.connect("attack", Callable(self, "notify_enemy_attacks"))
	
	enemy.anim_enemy("walk")
	var enemy_follow = PathFollow2D.new()
	enemy_follow.add_to_group("enemy")
	enemy_follow.rotates = false
	enemy_follow.loop = false
	path_follow.get_parent().add_child(enemy_follow)
	enemy_follow.h_offset = rng.randf_range(-75.0, 50.0) # Random position on the path
	enemy_follow.v_offset = rng.randf_range(-50.0, 40.0)
	enemy_follow.add_child(enemy)

func notify_enemy_attacks():
	enemy_attacks.emit()

func notify_game_over():
	var enemies_path_follow = get_enemies_path_follow(path_follow.get_parent().get_children())
	for enemy_index in range(0, enemies_path_follow.size()):
		var enemy = enemies_path_follow[enemy_index].get_child(0)
		enemy.is_game_over = true
		var anim = "idle" if enemy.reach_player else "walk"
		enemy.anim_enemy(anim)
	
func get_enemies_path_follow(array: Array[Node]):
	var enemy_instancies = []
	for index in range(0, array.size()):
		if array[index].is_in_group("enemy"):
			enemy_instancies.append(array[index])
	return enemy_instancies
