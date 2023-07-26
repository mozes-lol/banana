extends Node

# This dictates which vehicle the game systems will focus on to.
@onready var currentVehicle = get_node("/root/level_test_3d/car_test")

func _ready():
	get_node("start_game_on_timer").initiateStartTimer()
