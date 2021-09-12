extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Menu")
#	print(Global.Settings["Audio"]["Master"])
#	yield(get_tree().)
	
	


func _on_StartButton_pressed():
	get_tree().change_scene("res://Assets/Scenes/World.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	$OptionsPanel/Audio/VolumeSlider.value = Global.Settings["Audio"]["Master"]
	$OptionsPanel.show()


func _on_OKButton_pressed():
	$OptionsPanel.hide()


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	Global.Settings["Audio"]["Master"] = value
	Global.save_setting()
	$OptionsPanel/Audio/SoundTest.play()
