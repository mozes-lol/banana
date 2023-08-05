extends StaticBody3D

var level_controller
var current_vehicle

func _ready():
	level_controller = get_node("/root/level_test_3d/level_controller")
	print("Destination has been spawned.")

func _process(delta):
	# As this trigger is instantiated, this is to keep the destination pinned to
	# where it's supposed to be.
	# (Because I don't know how to instantiate nodes outside the parent since it's
	# Godot 4.1)
	global_position = get_node("/root/level_test_3d/level_controller").currentVehicle.destination_position
	global_rotation = get_node("/root/level_test_3d/level_controller").currentVehicle.destination_rotation

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	# It needs to be specified here that only the current vehicle is allowed to
	# trigger this area.
	if (body.driving_status == "Recording" && level_controller.currentVehicle == body):
		# prevents from immediately triggering the destination on spawn
		if (get_node("/root/level_test_3d/level_controller").currentVehicle.move_status == "auto"):
			level_controller.roundSuccess()
	
