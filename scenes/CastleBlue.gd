extends StaticBody2D

@export var enemy_spawner: Node
@export var health_bar: TextureProgressBar
# Tiempo que el sprite estará en rojo
var damage_duration = 0.1
var original_color

signal game_over

func _ready():
	original_color = modulate
	enemy_spawner.connect("enemy_attacks", Callable(self, "get_hurts"))

func get_hurts():
	receive_damage()
	if health_bar.value > 0:
		health_bar.value -= 20
		print("Player get hurts")
	else:
		game_over.emit()
		print("GAME OVER")

func receive_damage():
   	# Cambia el color a rojo
	modulate = Color(1, 0, 0)  # Rojo
	# Llama a restaurar el color original después de "damage_duration" segundos
	await get_tree().create_timer(damage_duration).timeout
	modulate = original_color  # Restauramos el color original
