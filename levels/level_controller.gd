extends Node

@export var vehiclePathnameList := []
# This dictates which vehicle the game systems will focus on to.
@export var vehiclePathnameListIndex = 0
var currentVehicle

func _ready():
	roundStart()

func roundStart():
	var vehicleSpawn = load(vehiclePathnameList[vehiclePathnameListIndex]).instantiate()
	add_child(vehicleSpawn)
	get_node("timer_controller").initiateStartTimer()
	
func roundSuccess():
	currentVehicle.move_status = "no_move"
	get_node("timer_controller").initiateEndTimer()
	print("The vehicle has reached its destination.")

func markAsCurrentVehicle(objectName):
	currentVehicle = objectName

func updateCameraTarget():
	get_node("/root/level_test_3d/level_controller/start_game_on_timer").target = currentVehicle
