extends Node

@onready var parent = get_node("/root/level_test_3d/level_controller")

func initiateStartTimer():
	get_node("start_timer").start()
	print("Get ready...")

func _on_start_timer_timeout():
	parent.currentVehicle.move_status = "auto"
	print("Go!")
