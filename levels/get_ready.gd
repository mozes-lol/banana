extends Panel

@onready var heartEmpty = preload("res://assets/fonts/heartEmpty.png")
@onready var heartFull = preload("res://assets/fonts/heartFull.png")
@onready var heart1 = get_node("/root/level_test_3d/ui/get_ready/MarginContainer/VBoxContainer/HBoxContainer/heart1")
@onready var heart2 = get_node("/root/level_test_3d/ui/get_ready/MarginContainer/VBoxContainer/HBoxContainer/heart2")
@onready var heart3 = get_node("/root/level_test_3d/ui/get_ready/MarginContainer/VBoxContainer/HBoxContainer/heart3")
@onready var level_controller = get_node("/root/level_test_3d/level_controller")

func _process(delta: float) -> void:
	if (level_controller.currentLives == 3):
		heart1.texture = heartFull
		heart2.texture = heartFull
		heart3.texture = heartFull
	elif (level_controller.currentLives == 2):
		heart1.texture = heartFull
		heart2.texture = heartFull
		heart3.texture = heartEmpty
	elif (level_controller.currentLives == 1):
		heart1.texture = heartFull
		heart2.texture = heartEmpty
		heart3.texture = heartEmpty
	elif (level_controller.currentLives == 0):
		heart1.texture = heartEmpty
		heart2.texture = heartEmpty
		heart3.texture = heartEmpty
