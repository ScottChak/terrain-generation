extends Spatial

export(int) var max_height = 32

func _ready():
	$CameraRig.rig_height_max = max_height
	pass

func _process(delta):
	$CameraRig.raise_rig(1, delta)
	$CameraRig.pivot_rig(1, delta)
	$CameraRig.bend_elbow(1, delta)
	pass
