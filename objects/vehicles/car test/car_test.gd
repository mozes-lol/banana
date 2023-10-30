extends CharacterBody3D

# movement
@export var speed = 10
@export var rotation_speed = 4.5
@export_enum("auto", "manual", "no_move") var move_status = "auto" # useful for debugging
# fuel
@export var max_fuel = 15.0
@export var current_fuel = max_fuel
@export var fuel_consume_rate = 0.8
@export var is_draining_fuel = false
# starting point and destination
@export var starting_position = Vector3()
@export var starting_rotation = Vector3()
@export var destination_position = Vector3()
@export var destination_rotation = Vector3()
# recording and replaying
var replay = []
var memory = {"L":0, "R":0}
@export var inputs = {"L":false, "R":false}
@export var frames = 0
# others
var rotation_direction = 0
var has_moved = false
var has_crashed = false
@export_enum("Recording", "Replaying") var driving_status = "Recording" 
@onready var levelController = get_node("/root/level_test_3d/level_controller")
@onready var destinationTrigger = preload("res://objects/destination/destination.tscn")

func _ready():
	moveToStartingPosition()
	get_parent().markAsCurrentVehicle(get_node("."))
	var destinationTriggerSpawn = destinationTrigger.instantiate() # change the index later
	destinationTriggerSpawn.global_position = destination_position
	destinationTriggerSpawn.global_rotation = destination_rotation
	add_child(destinationTriggerSpawn) # change to a position automatically
	print("A new vehicle has been spawned.")

func get_input():
	#	replay
	if driving_status == "Recording":
		if Input.is_action_just_pressed("steer_left"):
			memory.L = frames
		if Input.is_action_just_pressed("steer_right"):
			memory.R = frames
		if Input.is_action_just_released("steer_left"):
			replay.append({"key":"L", "startframe":memory.L, "endframe":frames})
		if Input.is_action_just_released("steer_right"):
			replay.append({"key":"R", "startframe":memory.R, "endframe":frames})
	# record
	if driving_status == "Replaying":
		for input in replay:
			if input.startframe == frames:
				inputs[input.key] = true
			if input.endframe == frames:
				inputs[input.key] = false
	if move_status == "auto":
		is_draining_fuel = true
		# vehicle moves AUTOMATICALLY
		if driving_status != "Replaying": # not replaying
			rotation_direction = Input.get_axis("steer_right", "steer_left")
		else:
			if inputs["R"] && inputs["L"]:
				rotation_direction = 0
			elif inputs["R"] == true:
				rotation_direction = -1
			elif inputs["L"] == true:
				rotation_direction = 1
			else:
				rotation_direction = 0
		velocity = transform.basis.z * speed
	elif move_status == "manual":
		is_draining_fuel = true
		# vehicle moves MANUALLY (Press W or S to move forward or backward)
		rotation_direction = Input.get_axis("steer_right", "steer_left")
		velocity = transform.basis.z * Input.get_axis("reverse", "forward") * speed
	elif move_status == "no_move":
		is_draining_fuel = false
		# vehicle does not move
		rotation_direction = 0
		velocity = Vector3.ZERO
		pass

func _process(delta):
	# consume fuel over time
	if is_draining_fuel == true:
		current_fuel -= fuel_consume_rate * delta
	if current_fuel <= 0 && driving_status == "Recording":
		if has_crashed == false:
			levelController.roundFail()
			has_crashed = true
			print("The vehicle has lost all fuel.")

func _physics_process(delta):
	# vehicle's movement
	get_input()
	rotation.y += rotation_direction * rotation_speed * delta
	move_and_slide()
	for i in get_slide_collision_count():
		if driving_status != "Replaying":
			var collision = get_slide_collision(i)
			if has_crashed == false:
				levelController.roundFail()
				has_crashed = true
				print("The vehicle has crashed.")
				print("Vehicle collided with: ", collision.get_collider().name)
			print("Collision Layer: " + str(collision.get_collider().get_collision_layer()))
	frames += 1

func moveToStartingPosition():
	position = starting_position
	rotation = starting_rotation
	frames = 0
