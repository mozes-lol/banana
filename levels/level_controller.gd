extends Node

@export var vehiclePathnameList := []
# This dictates which vehicle the game systems will focus on to.
@export var vehiclePathnameListIndex = 0
var currentVehicle

func _ready():
	roundStart()
	print(vehiclePathnameList.size())

func roundStart():
	if vehiclePathnameList.size() - 1 >= vehiclePathnameListIndex:
		var vehicleSpawn = load(vehiclePathnameList[vehiclePathnameListIndex]).instantiate()
		add_child(vehicleSpawn)
		get_node("timer_controller").initiateStartTimer()
		print("A new round is starting.")
	else:
		print("All cars have already been driven.")
	
func roundSuccess():
	currentVehicle.move_status = "no_move"
	get_node("timer_controller").initiateEndTimer()
	print("The vehicle has reached its destination.")

func newRound():
	vehiclePathnameListIndex += 1
	roundStart()

func markAsCurrentVehicle(objectName):
	currentVehicle = objectName

func updateCameraTarget():
	get_node("/root/level_test_3d/level_controller/start_game_on_timer").target = currentVehicle
