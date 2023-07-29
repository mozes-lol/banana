extends Node

func goToMainMenu():
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")

func goToGame():
	get_tree().change_scene_to_file("res://levels/level_test_3d.tscn")
