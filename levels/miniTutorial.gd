extends Node

var tutorialIndex = 0

@onready var textPrompt = get_node("/root/level_test_3d/ui/textPrompt")

func _on_start_timer_timeout(): # when the start timer ends
	if tutorialIndex == 0:
		textPrompt.text = "Follow the green arrow to your destination."
		tutorialIndex = 1
		get_node("timer_tutorial").start()
	
func _on_timer_tutorial_timeout():
	if tutorialIndex == 1:
		textPrompt.text = "And for the love of all holy, DON'T CRASH."
		tutorialIndex = 2
		get_node("timer_tutorial").start()
	else:
		textPrompt.text = ""
