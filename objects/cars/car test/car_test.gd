extends CharacterBody3D

var main_speed = 5.0
var turn_speed = 5.0

func _process(delta):
	pass

func _physics_process(delta):
	
	velocity.z = -1 * main_speed
	
	move_and_slide()
