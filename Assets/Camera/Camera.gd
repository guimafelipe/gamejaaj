extends Camera

const SMOOTH_SPEED = 7
const UP = Vector3(0, 1, 0)

var center
var cam_base


func _ready():
	cam_base = get_parent()
	

func set_center(new_center):
	center = new_center
	set_as_toplevel(true)

func _physics_process(delta):
	if center != null:
		var desired_pos = cam_base.global_transform.origin
		translation = translation.linear_interpolate(desired_pos, delta*SMOOTH_SPEED)
		look_at(center, UP)

