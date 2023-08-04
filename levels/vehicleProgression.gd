extends Label

@onready var levelController
@onready var timer = get_node("/root/level_test_3d/level_controller/timer_controller/start_timer")
@onready var timerText = get_node("/root/level_test_3d/ui/get_ready/MarginContainer/VBoxContainer/timer")

func _process(delta: float) -> void:
	var thing = str(int(timer.get_time_left()))
	timerText.text = thing

