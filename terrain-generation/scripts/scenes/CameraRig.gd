extends Spatial

export var elbow_rotation_speed = PI / 2

func rotate_elbow(direction, delta):
	$Elbow.rotate_object_local(Vector3.UP, direction * elbow_rotation_speed * delta)
