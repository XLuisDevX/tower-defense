extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	toggleSettingsElementsVisibility(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_settings_pressed():
	visible = true
	toggleSettingsElementsVisibility(true)


func _on_close_settings_close_settings():
	toggleSettingsElementsVisibility(false)
	visible = false
	
func toggleSettingsElementsVisibility(visible: bool):
	$SettingsTitle.visible = visible
	#$VolumeSlider.visible = visible
	$VBoxContainer/VolumeSlider.visible = visible
	$VBoxContainer/ShowDamage.visible = visible
	#$ShowDamage.visible = visible
	$VBoxContainer/GameSpeed.visible = visible
	$VBoxContainer/CloseSettings.visible = visible
	#$GameSpeed.visible = visible
	#$CloseSettings.visible = visible
	
