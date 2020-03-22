extends Spatial

var rig_pivot_init = 0
var rig_pivot_min = -0.45 * PI
var rig_pivot_max = 0.45 * PI
var rig_pivot_speed = 0.5 * PI

var elbow_bend_init = 0.05 * PI
var elbow_bend_min = 0.05 * PI
var elbow_bend_max = 0.45 * PI
var elbow_bend_speed = 0.5 * PI

func _ready():
	rotation.y = rig_pivot_init
	#	Inverting so positive values go up
	$Elbow.rotation.x = -elbow_bend_init

func pivot_rig(direction, delta):
	#	Pivoting rig instead of elbow
	rotate_object_local(Vector3.UP, direction * rig_pivot_speed * delta)
	rotation.y = clamp(rotation.y, rig_pivot_min, rig_pivot_max)

func bend_elbow(direction, delta):	
	#	Rotating around LEFT so positive values go up
	$Elbow.rotate_object_local(Vector3.LEFT, direction * elbow_bend_speed * delta)
	#	Inverting so positive values go up
	$Elbow.rotation.x = clamp($Elbow.rotation.x, -elbow_bend_max, -elbow_bend_min)
