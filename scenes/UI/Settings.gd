extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	toggleSettingsElementsVisibility(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_settings_pressed():
	visible = true
	$BannerVertical.visible = true
	$BannerVertical/AnimationPlayer.play("pop_up")
	


func _on_animation_player_animation_finished(anim_name):
	var visibility = true if anim_name == "pop_up" else false
	toggleSettingsElementsVisibility(visibility)
	visible = visibility


func _on_close_settings_close_settings():
	toggleSettingsElementsVisibility(false)
	$BannerVertical/AnimationPlayer.play("close")
	
func toggleSettingsElementsVisibility(visible: bool):
	$SettingsTitle.visible = visible
	$VolumeSlider.visible = visible
	$CheckBox.visible = visible
	$GameSpeed.visible = visible
	$CloseSettings.visible = visible
	#$BannerVertical/AnimationPlayer.play("close")
	
