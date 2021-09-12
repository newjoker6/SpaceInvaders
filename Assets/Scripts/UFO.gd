extends KinematicBody2D


var velocity: Vector2 = Vector2.ZERO
var speed:int = 30

var points: int

var color: Array = [Color.red, Color.purple, Color.green, Color.white, Color.blue]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var color_index = randi() %color.size()
	$Sprite.self_modulate = color[color_index]
	points = int(rand_range(100,300))
	velocity.x = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.position.x > 270:
		print("deleted")
		self.queue_free()
	move_and_slide(velocity, Vector2.UP)


func destroy():
	get_tree().call_group("GUI","update_score", points)
	self.queue_free()
