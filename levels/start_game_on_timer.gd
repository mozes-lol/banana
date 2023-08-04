extends Node

@onready var parent = get_node("/root/level_test_3d/level_controller")
@onready var getReadyUi = get_node("/root/level_test_3d/ui/get_ready")

func initiateStartTimer():
	get_node("start_timer").start()
	print("Get ready...")

func initiateEndTimer():
	get_node("end_timer").start()
	print("Round is ending...")

func _on_start_timer_timeout():
	getReadyUi.disableGetReadyUI()
	parent.currentVehicle.move_status = "auto"
	parent.startAllSubVehicles()
	print("Go!")

func _on_end_timer_timeout():
	parent.newRound()
