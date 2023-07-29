extends Node

@onready var sceneLoader = get_node("/root/SceneLoader")

func _on_play_pressed():
	sceneLoader.goToGame()
