extends Node

@export var UI_gold: Node
@export var UI_Score: Label
@export var player: StaticBody2D
@export var enemy_spawner: Node
@export var game_over_menu: Node
@export var variable: int

var GameOverMenu: Node

var _is_game_over = false

signal update_gold

func _ready():
	GameOverMenu = get_parent().get_node("GameOverMenu")
	enemy_spawner = get_parent().get_node("EnemySpawner")
	
	GlobalScene.connect("gold_updated", Callable(self, "notify_update_gold"))
	GlobalScene.connect("score_updated", Callable(self, "notify_update_score"))
	GlobalScene.connect("game_speed_updated", Callable(self, "notify_update_game_speed"))
	
	player.connect("game_over", Callable(self, "_on_castle_blue_game_over"))
	if UI_gold:
		print("Nodo asignado desde el editor:", UI_gold.name)
	else:
		print("El nodo asignado está vacío o no está en el árbol.")
	
	if UI_Score:
		print("Nodo asignado desde el editor:", UI_Score.name)
		UI_Score.text = "SCORE: 0"
	else:
		print("El nodo asignado está vacío o no está en el árbol.")
		
	if GameOverMenu:
		print("Nodo asignado desde el editor:", GameOverMenu.name)
	else:
		print("El nodo asignado está vacío o no está en el árbol.")

func _on_castle_blue_game_over():
	if !_is_game_over:
		_is_game_over = true
		_show_game_over()
		enemy_spawner.notify_game_over()
		
		# AUTO RETRY GAME TIMER
		#var game_over_timer = Timer.new()
		#add_child(game_over_timer)
		#
		#game_over_timer.wait_time = 2
		#game_over_timer.one_shot = true
		#
		#game_over_timer.connect("timeout", Callable(self, "_on_game_over_timer_timeout"))
		#
		#game_over_timer.start()
	
func _show_game_over():
	#UI.get_node("GameOver").visible = true
	GameOverMenu.visible = true
	game_over_menu.play_anim("pop_up")
	
func _on_game_over_timer_timeout():
	get_tree().reload_current_scene()

func notify_update_gold():
	if UI_gold:
		UI_gold.update_gold()

func notify_update_score():
	if UI_Score:
		UI_Score.text = "SCORE: " + str(GlobalScene.get_score())

func notify_update_game_speed():
	# TODO: Update all enemy's speed
	print(get_tree().get_nodes_in_group("enemy"))
	# TODO: Update all tower's speed and disable upgrade attack speed button if game is in FAST mode
