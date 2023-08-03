extends Node3D

@onready var sceneLoader = get_node("/root/SceneLoader")

func _on_play_pressed():
	sceneLoader.goToGame()
	print("Play")

func _on_settings_pressed() -> void:
	get_node("/root/main_menu/ui/settings").show()
	get_node("/root/main_menu/ui/main_menu").hide()

func _on_back_pressed() -> void:
	get_node("/root/main_menu/ui/settings").hide()
	get_node("/root/main_menu/ui/main_menu").show()
