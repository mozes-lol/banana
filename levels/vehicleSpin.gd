extends MeshInstance3D

func _process(delta: float) -> void:
	rotate(Vector3(0, 0, 1), 1 * delta)
	rotate(Vector3(1, 0, 0), .5 * delta)
	rotate(Vector3(0, 1, 0), 1.5 * delta)
