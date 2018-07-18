extends Spatial

var angle
const UP = Vector3(0,1,0)
const angular_speed = 2*PI/3

func _ready():
	angle = atan2(rotation.x, rotation.z)
	pass

func _physics_process(delta):
	var new_angle = update_angle(delta)
	rotate_y(new_angle - angle)

func update_angle(delta):
	return angle + delta * angular_speed