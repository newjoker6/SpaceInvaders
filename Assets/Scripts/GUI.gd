extends CanvasLayer


onready var PointsLabel:Node = $Label
var score:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("GUI")
	if Global.CurrentScore != 0:
		PointsLabel.text = "Score: %s" %Global.CurrentScore
	else:
		PointsLabel.text = "Score: %s" %score


func update_score(points:int):
	score += points
	PointsLabel.text = "Score: %s" %score


func gameover():
	Global.CurrentScore = score
	yield(get_tree(),"idle_frame")
	if Global.CurrentScore > Global.HighScore:
		Global.HighScore = Global.CurrentScore
		Global.save_highscore()
	get_tree().change_scene("res://Assets/StaticAssets/Prefabs/GameOver.tscn")


func change_health():
	$PlayerHealth.value -= 1
