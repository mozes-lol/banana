extends Node

@onready var textPrompt = get_node("/root/level_test_3d/ui/textPrompt")

func promptCrashText(type):
	if type == "object":
		textPrompt.text = "You crashed onto an OBJECT."
	elif type == "border":
		textPrompt.text = "You crashed onto an BORDER."
	elif type == "gas":
		textPrompt.text = "You ran out of gas."
