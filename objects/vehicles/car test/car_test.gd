extends CharacterBody3D

@export var speed = 10
@export var rotation_speed = 4.5
@export_enum("auto", "manual", "no_move") var move_status = "auto" # useful for debugging

var rotation_direction = 0

func _ready():
	print("A new vehicle has been spawned.")
	get_parent().markAsCurrentVehicle(get_node("."))

func get_input():
	rotation_direction = Input.get_axis("steer_right", "steer_left")
	if move_status == "auto":
		# vehicle moves AUTOMATICALLY
		velocity = transform.basis.z * speed
	elif move_status == "manual":
		# vehicle moves MANUALLY (Press W or S to move forward or backward)
		velocity = transform.basis.z * Input.get_axis("reverse", "forward") * speed
	elif move_status == "no_move":
		# vehicle does not move
		velocity = Vector3.ZERO
		pass

func _physics_process(delta):
	get_input()
	rotation.y += rotation_direction * rotation_speed * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.get_collider().name)
