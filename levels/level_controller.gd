extends Node

# game variables
@export var currentLives =  3
@export_enum("Success", "Fail") var roundStatus = "Success"
# vehicle listing
@export var vehiclePathnameList := []
@export var vehiclePathnameListIndex = 0
var currentVehicle # This dictates which vehicle the game systems will focus on to.
@export var vehicleReadyList := [] # For calling all vehicles to move/stop
# onready
@onready var sceneLoader = get_node("/root/SceneLoader")
@onready var fuelBar = get_node("/root/level_test_3d/ui/fuel_bar")

@onready var audioStreamPlayerMusic: AudioStreamPlayer = $AudioStreamPlayerMusic
var current_music_volume = 0

func _ready():
	current_music_volume = AudioControl.get_music_bus_volume_linear()
	newRound()

func _process(delta):
	fuelBar.value = currentVehicle.current_fuel

func roundStart():
	AudioControl.set_music_bus_volume_linear(current_music_volume)
	for i in vehicleReadyList:
		i.moveToStartingPosition()
		# change collision layer from VehicleMain to VehicleSub
		i.collision_mask = 8
	# Remove the current failed vehicle to make way for the new resetted one
	if roundStatus == "Fail":
		currentLives -= 1
		currentVehicle.queue_free()
		print("Removed previously failed vehicle")
		if currentLives <= 0:
			sceneLoader.goToMainMenu()
	# Spawn vehicle
	if vehiclePathnameList.size() - 1 >= vehiclePathnameListIndex:
		var vehicleSpawn = load(vehiclePathnameList[vehiclePathnameListIndex]).instantiate()
		add_child(vehicleSpawn)
		fuelBar.max_value = currentVehicle.max_fuel
		print("A new round is starting.")
		get_node("timer_controller").initiateStartTimer()
	else:
		sceneLoader.goToMainMenu()
		print("All cars have already been driven.")
	
func roundSuccess():
	# adds vehilce to vehicleReadyList
	vehicleReadyList.append(currentVehicle)
	currentVehicle.driving_status = "Replaying"
	# Go to the next car
	roundStatus = "Success"
	vehiclePathnameListIndex += 1
	currentVehicle.move_status = "no_move"
	stopAllSubVehicles()
	get_node("timer_controller").initiateEndTimer()
	print("The vehicle has reached its destination.")

func roundFail():
	current_music_volume = AudioControl.get_music_bus_volume_linear()
	AudioControl.set_music_bus_volume_linear(0)
	# Restart car and lose a life
	roundStatus = "Fail"
	currentVehicle.move_status = "no_move"
	stopAllSubVehicles()
	get_node("timer_controller").initiateEndTimer()
	pass

func newRound():
	roundStart()
	fuelBar.max_value = currentVehicle.max_fuel

func markAsCurrentVehicle(objectName):
	currentVehicle = objectName

func startAllSubVehicles():
	for vehicle in vehicleReadyList:
		vehicle.move_status = "auto"

func stopAllSubVehicles():
	for vehicle in vehicleReadyList:
		vehicle.move_status = "no_move"

func updateCameraTarget():
	get_node("/root/level_test_3d/level_controller/start_game_on_timer").target = currentVehicle
