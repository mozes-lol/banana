extends CharacterBody3D

# movement
@export var speed = 10
@export var rotation_speed = 4.5
@export_enum("auto", "manual", "no_move") var move_status = "auto" # useful for debugging
# fuel
const max_fuel = 100
@export var current_fuel = max_fuel
@export var fuel_consume_rate = 1
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
var is_recording = false # tells when the input should be recorded
var is_replaying = false # dictates whether some vehicle systems should work or
# let the replay system work for itself
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
	if is_recording == true && is_replaying == false:
		if Input.is_action_just_pressed("steer_left"):
			memory.L = frames
		if Input.is_action_just_pressed("steer_right"):
			memory.R = frames
		if Input.is_action_just_released("steer_left"):
			replay.append({"key":"L", "startframe":memory.L, "endframe":frames})
		if Input.is_action_just_released("steer_right"):
			replay.append({"key":"R", "startframe":memory.R, "endframe":frames})
	# record
	if is_recording == false && is_replaying == true:
		for input in replay:
			if input.startframe == frames:
				inputs[input.key] = true
			if input.endframe == frames:
				inputs[input.key] = false
	if move_status == "auto":
		# vehicle moves AUTOMATICALLY
		if is_replaying == false: # not replaying
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
		# vehicle moves MANUALLY (Press W or S to move forward or backward)
		rotation_direction = Input.get_axis("steer_right", "steer_left")
		velocity = transform.basis.z * Input.get_axis("reverse", "forward") * speed
	elif move_status == "no_move":
		# vehicle does not move
		rotation_direction = 0
		velocity = Vector3.ZERO
		pass

func _physics_process(delta):
	# consume fuel over time
	if move_status != "no_move":
		current_fuel -= fuel_consume_rate * delta
	# vehicle's movement
	get_input()
	rotation.y += rotation_direction * rotation_speed * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if has_crashed == false:
			levelController.roundFail()
			has_crashed = true
			print("Vehicle collided with: ", collision.get_collider().name)
	frames += 1

func moveToStartingPosition():
	position = starting_position
	rotation = starting_rotation
