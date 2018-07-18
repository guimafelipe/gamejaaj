extends Camera

var center
const UP = Vector3(0,1,0)
var angle
var offset

func _ready():
	pass
	# offset = self.global_transform.origin - center.global_transform.origin 

func _physics_process(delta):
	pass
	# look_at(center, UP)

func set_center(new_center):
	pass
	#self.center = new_center