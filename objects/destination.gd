extends StaticBody3D


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	# It needs to be specified here that only the current vehicle is allowed to
	# trigger this area.
	print("Destination has been reached.")
