extends Node

@export var vehiclePathnameList := []
# This dictates which vehicle the game systems will focus on to.
var currentVehicle

func _ready():
	var vehicleSpawn = load(vehiclePathnameList[0]).instantiate() # change the index later
	add_child(vehicleSpawn)
	get_node("start_game_on_timer").initiateStartTimer()
	pass
	
	
func markAsCurrentVehicle(objectName):
	currentVehicle = objectName
	pass

func updateCameraTarget():
	get_node("/root/level_test_3d/level_controller/start_game_on_timer").target = currentVehicle
