extends Label

@onready var levelController = get_node("/root/level_test_3d/level_controller")
@onready var timer = get_node("/root/level_test_3d/level_controller/timer_controller/start_timer")
@onready var timerText = get_node("/root/level_test_3d/ui/get_ready/MarginContainer/VBoxContainer/timer")

func _ready() -> void:
	print(levelController.vehiclePathnameList.size())

func _process(delta: float) -> void:
	text = str(levelController.vehiclePathnameListIndex) + " of " + str(levelController.vehiclePathnameList.size()) + " cars driven"
	var thing = str(int(timer.get_time_left()))
	timerText.text = thing

