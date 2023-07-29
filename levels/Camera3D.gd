extends Camera3D

@onready var parent = get_node("/root/level_test_3d/level_controller")

var target
@export var offsetToTarget = Vector3(0, 12.57, 12.845)

func _ready():
	pass

func _process(delta):
	target = parent.currentVehicle
	if target != null:
		global_position = target.global_position + offsetToTarget
	pass
