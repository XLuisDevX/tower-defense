extends Node2D

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@export var enemySpawnerTimer: Timer
@export var speed = 100
@export var enemiesToSpawn = []

var torch_goblin = preload("res://scenes/torch_goblin.tscn")
var tnt_goblin = preload("res://scenes/tnt_goblin.tscn")
var barrel_goblin = preload("res://scenes/barrel_goblin.tscn")
var global_delta = 0
var enemy_instance
var anim_enemy = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#enemy_instance = torch_goblin.instantiate()
	enemySpawnerTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Path2D/PathFollow2D.progress_ratio < 1:
		animEnemy(delta)
	else:
		if enemy_instance.has_method("play_anim"):
			enemy_instance.play_anim("attack")	

func animEnemy(delta):
	# Animar el personaje
	if enemy_instance == null:
		return
	#enemy_instance.get_node("AnimatedSprite2D").play("walk")
	if enemy_instance.has_method("play_anim"):
		enemy_instance.play_anim("walk")
	# Recorrer el path
	path_follow.progress += speed * delta


func _on_spawn_timer_timeout():
	#enemy_instance = enemy_instance if enemy_instance != null else torch_goblin.instantiate()
	#$Path2D/PathFollow2D.add_child(enemy_instance)
	#anim_enemy = true
	pass
