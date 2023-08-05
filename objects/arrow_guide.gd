extends Node3D

@export var offset = Vector3()

@onready var levelController = get_node("/root/level_test_3d/level_controller")
@onready var destination = get_node("/root/level_test_3d/destination")

func _process(delta: float) -> void:
	global_position = levelController.currentVehicle.global_position + offset
	look_at(levelController.currentVehicle.destination_position)
