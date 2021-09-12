extends Control


var UFO = preload("res://Assets/StaticAssets/Prefabs/UFO.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$UI.score = Global.CurrentScore
	check_enemies()
	$Invader1.play()

#func _process(delta):
#	print($Aliens.get_children().size())
func set_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Global.Settings["Audio"]["Master"])


func check_enemies():
	if $Aliens.get_children().size() == 0:
		Global.CurrentScore = $UI.score
		get_tree().reload_current_scene()
	if $Aliens.get_children().size() <= 30:
		print("Play Invader 2")
		if not $Invader2.is_playing():
			$Invader1.stop()
			$Invader2.play()
		for child in $Aliens.get_children():
			child.side_speed = 20
			child.drop_speed = 20
	if $Aliens.get_children().size() <= 20:
		if not $Invader3.is_playing():
			$Invader2.stop()
			$Invader3.play()
		for child in $Aliens.get_children():
			child.side_speed = 30
			child.drop_speed = 30
	if $Aliens.get_children().size() <= 10:
		if not $Invader4.is_playing():
			$Invader3.stop()
			$Invader4.play()
		for child in $Aliens.get_children():
			child.side_speed = 40
			child.drop_speed = 40
	if $Aliens.get_children().size() == 1:
		for child in $Aliens.get_children():
			child.side_speed = 150
			child.drop_speed = 150
#	yield(get_tree().create_timer(0.5),"timeout")
	yield(get_tree(),"idle_frame")
	check_enemies()


func _on_UFOTimer_timeout():
	var chance = randi() %2
	match chance:
		0:
			print("no spawn")
		1:
			print("spawn")
			var ufo_inst = UFO.instance()
			ufo_inst.position.y += 16
			add_child(ufo_inst)
	$UFOTimer.start()
