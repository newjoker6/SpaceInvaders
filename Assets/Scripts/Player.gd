extends KinematicBody2D


var velocity: Vector2 = Vector2.ZERO
var up: Vector2 = Vector2.UP

var speed: int = 58

var lazer: PackedScene = preload("res://Assets/StaticAssets/Prefabs/Lazer.tscn")

var can_shoot:bool = true

var life:int = 3


func _process(_delta):
	move_and_slide(velocity, up)


func _physics_process(_delta):
	movement()
	shoot()


func movement():
	if Input.is_action_pressed("Left"):
		velocity.x = -speed
	elif Input.is_action_pressed("Right"):
		velocity.x = speed
	else:
		velocity.x = 0


func shoot():
	if Input.is_action_just_pressed("Shoot") and can_shoot == true:
		var lazer_inst = lazer.instance()
		lazer_inst.position = self.position

		lazer_inst.position.y -= 17

		get_parent().add_child(lazer_inst)
		$ShootSound.play()
		can_shoot = false
		$ShootTimer.start()


func _on_ShootTimer_timeout():
	can_shoot = true


func hurt():
	if life > 1:
		life -= 1
		$AnimationPlayer.play("Hit")
		get_tree().call_group("GUI","change_health")
		$DeathSound.play()

	elif life <= 1:
		life -= 1
		$AnimationPlayer.play("Hit")
		get_tree().call_group("GUI","gameover")










