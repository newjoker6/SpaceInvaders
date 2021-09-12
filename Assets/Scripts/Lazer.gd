extends KinematicBody2D


var velocity: Vector2 = Vector2.ZERO

var speed: int = -300

var colors: Array = [Color.aliceblue, Color.darkorchid, Color.gold, Color.webmaroon, Color.darkturquoise, Color.blueviolet, Color.rebeccapurple]


func _ready():
	connect_signals()
	randomize()
	var index:int = randi() %colors.size()
	$Sprite.self_modulate = colors[index]
	check_position()
	


func _process(delta):
	velocity.y = speed
	move_and_slide(velocity)

func connect_signals():
	$DetectionArea.connect("body_entered", self, "_on_body_enter")


func _on_body_enter(body):
	if not "Player" in body.name and not "Alien" in body.name:
		body.destroy()
		self.queue_free()
	elif "Alien" in body.name:
		print("alien detexted")
#		yield(get_tree().create_timer(0.5),"timeout")
#		body.change_speed()
		body.destroy()
		self.queue_free()
	elif "UFO" in body.name:
		body.destory()
		self.queue_free()
	elif "Player" in body.name:
#		pass
		body.hurt()

func check_position():
	yield(get_tree().create_timer(1),"timeout")
	if self.position.y < 0 or self.position.y > 300:
		self.queue_free()
	check_position()
