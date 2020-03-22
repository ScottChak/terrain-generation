extends Spatial

func _ready():
	pass

func _process(delta):
	$CameraRig.pivot_rig(1, delta)
	$CameraRig.bend_elbow(1, delta)
	pass
