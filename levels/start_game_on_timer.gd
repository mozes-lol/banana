extends Node

func initiateStartTimer():
	get_node("start_timer").start()
	print("Get ready...")

func _on_start_timer_timeout():
	get_node("/root/level_test_3d/level_controller").currentVehicle.move_status = "auto"
	print("Go!")
