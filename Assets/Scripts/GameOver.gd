extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.text = "Score: %s" %Global.CurrentScore 
	$HighscoreLabel.text = "Highscore: %s" %Global.HighScore
	yield(get_tree().create_timer(5),"timeout")
	Global.CurrentScore = 0
	get_tree().change_scene("res://Assets/StaticAssets/Prefabs/MainMenu.tscn")
