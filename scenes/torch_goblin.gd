extends CharacterBody2D

@export var gold_scene = preload("res://scenes/gold_bag.tscn")
var game_manger = load("res://scenes/game_manager.tscn").instantiate()

var speed = 100
var health = 40 # Life points will increment during rounds to enemies more difficul to be defeated
var aimed = false
var drops_gold = false

var is_game_over = false # if true stop attacking and play idle anim
var reach_player = false # if false when is game over still playing walk anim until reach player castle
var _gameManagerScript

signal attack

func _ready():
	#_gameManager = game_manager_scene.instantiate()
	_gameManagerScript = game_manger.get_script()
	
func _physics_process(delta):
	var path_follow = get_parent() as PathFollow2D
	path_follow.progress += speed * delta
	var path = path_follow.get_parent() as Path2D
	if path_follow.progress >= 1.0:
		path_follow.h_offset = 0

func take_damage(amount):
	health -= amount
	if health <= 0:
		if drops_gold: _drop_gold()
		queue_free()

func anim_enemy(anim: StringName):
	$AnimatedSprite2D.play(anim)


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		reach_player = true
		# Cuando llegamos al castillo sabemos que es el final de la ruta, por tanto, 
		# cambiamos la animación de los enemigos
		anim_enemy("attack") if !is_game_over else anim_enemy("idle")
		speed = 0 # stops enemy

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "attack":
		attack.emit()
		
func set_aimed(aimed: bool):
	aimed = true
	$Marker.visible = aimed
	
func _drop_gold():
	var gold_bag = gold_scene.instantiate()
	#gold_bag.connect("collect_gold", Callable(game_manger, "notify_collect_gold"))
	get_parent().add_child(gold_bag)
