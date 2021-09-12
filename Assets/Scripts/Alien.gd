extends KinematicBody2D


var lazer: PackedScene = preload("res://Assets/StaticAssets/Prefabs/Lazer.tscn")

var velocity: Vector2 = Vector2.ZERO
var up: Vector2 = Vector2.UP

var drop_speed: int = 12
var side_speed:int = 12
var speed_mult:float = 0.05
var initial_position: Vector2

export var points: int


enum {
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT
}
var STATE = MOVE_LEFT


var PREVIOUS_STATE
var shoot_time:float

func _ready():
	randomize()
	shoot_time = rand_range(2,3)
	self.add_to_group("Aliens")
	initial_position = self.position
	shoot()
	$AnimationPlayer.play("Moving")


func _process(_delta):
	move()
	move_and_slide(velocity, up)


func destroy():
	get_tree().call_group("GUI","update_score", points)
	$DeathSound.play()
	yield(get_tree().create_timer(0.25),"timeout")
	self.queue_free()


func move():	
	match STATE:
		MOVE_LEFT:
			velocity.x = side_speed * -1

		MOVE_RIGHT:
			velocity.x = -side_speed * -1

		MOVE_DOWN:
			velocity.x = 0
			velocity.y = + drop_speed
			if self.position.y >= initial_position.y + 16:
				velocity.y = 0
				if PREVIOUS_STATE == MOVE_LEFT:
					STATE = MOVE_RIGHT
				elif PREVIOUS_STATE == MOVE_RIGHT:
					STATE = MOVE_LEFT


func change_direction():
	if STATE == MOVE_LEFT or STATE == MOVE_RIGHT:
		if !STATE == MOVE_DOWN:
			initial_position = self.position
			STATE = MOVE_DOWN


func _on_Area2D_body_entered(body: Node):
	if "Player" in body.name:
		get_tree().call_group("GUI","gameover")
	elif "Wall" in body.name:
		get_tree().call_group("Aliens", "set_state", STATE)
		yield(get_tree().create_timer(0.1),"timeout")
		get_tree().call_group("Aliens", "change_direction")


func shoot():
	yield(get_tree().create_timer(shoot_time),"timeout")
	if not $RayCast2D.is_colliding():
		var lazer_inst = lazer.instance()
		lazer_inst.position = self.position
		lazer_inst.position.y += 17
		lazer_inst.speed *= -1
		get_parent().get_parent().add_child(lazer_inst)
	shoot()


func set_state(state):
	PREVIOUS_STATE = state


