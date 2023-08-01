extends CharacterBody3D

# No need to delete this in the level. It automatically removes itself upon game start.

func _ready():
	queue_free()
