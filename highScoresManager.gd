extends Node

var config = ConfigFile.new()
var save_path = "user://highscores.cfg"

func save_highscore(player_name: String, score: int):
	# Load existing file if it exists
	config.load(save_path)
	
	# Add new highscore
	config.set_value("highscores", player_name, score)
	
	# Save the file
	config.save(save_path)

func load_highscores() -> PackedStringArray:
	# Load the file
	var err = config.load(save_path)
	
	# If the file doesn't exist, return an empty dictionary
	if err != OK:
		return []
	
	# Return all highscores
	return config.get_section_keys("highscores")

func get_highscore(player_name: String) -> int:
	config.load(save_path)
	return config.get_value("highscores", player_name, 0)  # 0 is the default value if not found
