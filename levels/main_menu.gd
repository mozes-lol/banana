extends Node3D

@onready var sceneLoader = get_node("/root/SceneLoader")

func _on_play_pressed():
	sceneLoader.goToGame()
	print("Play")
