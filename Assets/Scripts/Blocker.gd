extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	check_children()


func check_children():
	yield(get_tree().create_timer(5),"timeout")
	if self.get_children().size() == 0:
		self.queue_free()
	check_children()
