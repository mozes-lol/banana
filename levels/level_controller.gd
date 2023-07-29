extends Node

@export var currentLives =  3

@export_enum("Success", "Fail") var roundStatus = "Success"

@onready var levelController = get_node("/root/SceneLoader")

@export var vehiclePathnameList := []
# This dictates which vehicle the game systems will focus on to.
@export var vehiclePathnameListIndex = 0
var currentVehicle

func _ready():
	roundStart()
	print(vehiclePathnameList.size())

func roundStart():
	# Remove the current failed vehicle to make way for the new resetted one
	if roundStatus == "Fail":
		currentVehicle.queue_free()
		print("Removed previously failed vehicle")
	# Spawn vehicle
	if vehiclePathnameList.size() - 1 >= vehiclePathnameListIndex:
		var vehicleSpawn = load(vehiclePathnameList[vehiclePathnameListIndex]).instantiate()
		add_child(vehicleSpawn)
		get_node("timer_controller").initiateStartTimer()
		print("A new round is starting.")
	else:
		levelController.goToMainMenu()
		print("All cars have already been driven.")
	
func roundSuccess():
	# Go to the next car
	roundStatus = "Success"
	vehiclePathnameListIndex += 1
	currentVehicle.move_status = "no_move"
	get_node("timer_controller").initiateEndTimer()
	print("The vehicle has reached its destination.")

func roundFail():
	# Restart car and lose a life
	roundStatus = "Fail"
	currentLives -= 1
	currentVehicle.move_status = "no_move"
	get_node("timer_controller").initiateEndTimer()
	print("The vehicle has crashed.")
	pass

func newRound():
	roundStart()

func markAsCurrentVehicle(objectName):
	currentVehicle = objectName

func updateCameraTarget():
	get_node("/root/level_test_3d/level_controller/start_game_on_timer").target = currentVehicle
