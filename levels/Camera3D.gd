extends Camera3D

var target
@export var offsetToTarget = Vector3(0, 12.57, 12.845)

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node("/root/level_test_3d/car_test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = target.global_position + offsetToTarget
