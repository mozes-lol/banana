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
	if move_status == "auto":
		# vehicle moves AUTOMATICALLY
		is_recording = true
		rotation_direction = Input.get_axis("steer_right", "steer_left")
		velocity = transform.basis.z * speed
	elif move_status == "manual":
		# vehicle moves MANUALLY (Press W or S to move forward or backward)
		is_recording = true
		rotation_direction = Input.get_axis("steer_right", "steer_left")
		velocity = transform.basis.z * Input.get_axis("reverse", "forward") * speed
	elif move_status == "no_move":
		# vehicle does not move]
		is_recording = false # not sure if I should keep this here
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

func moveToStartingPosition():
	position = starting_position
	rotation = starting_rotation
