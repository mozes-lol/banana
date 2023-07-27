extends Node

@export var vehiclePathnameList := []
# This dictates which vehicle the game systems will focus on to.
var currentVehicle

func _ready():
	var vehicleSpawn = load(vehiclePathnameList[0]).instantiate()
	add_child(vehicleSpawn)
	#get_node("start_game_on_timer").initiateStartTimer()
	pass
