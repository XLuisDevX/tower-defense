extends Node2D

var current_wave = 0
var init_wave_enemies = 5
var current_wave_data = {}
var wave_increment = 1.75
var growth_factor = 1
var init_spawn_interval = 2

var init_gold_rate = 0.0
var increment_factor = 0.5

var NUM_WAVES = 51
# Called when the node enters the scene tree for the first time.
func _ready():
	#test()
	gold_test()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func test():
	var wave_index = 1
	for i in range(wave_index, NUM_WAVES):
		var numEnemies = int(init_wave_enemies + (wave_index * wave_increment) * (growth_factor ** wave_index))
		if wave_index % 5 == 0:
			print("Num of enemies in round " + str(wave_index) + ": BOSS ROUND")
		else:
			print("Num of enemies in round " + str(wave_index) + ": " + str(numEnemies))
		wave_index += 1

func gold_test():
	var wave_index = 1
	for i in range(wave_index, NUM_WAVES):
		var gold_rate = init_gold_rate + (increment_factor * (wave_index-1))
		if gold_rate > 0.35:
			gold_rate = 0.35
		if wave_index % 5 == 0:
			print("BOSS WAVE")
		else:
			print("Gold rate in wave "+str(wave_index)+": "+str(gold_rate))
		wave_index += 1
