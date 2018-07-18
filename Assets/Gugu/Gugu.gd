extends KinematicBody

const RIGHT = 1
const LEFT = -1

var speed = 500
var direction = Vector3()
var angle = 0
var angularSpeed = 2*PI/6 
var rotation_center
var rotation_radius
var gravity = -9.8
var velocity = Vector3()

var is_moving # check if it's moving and animation not playing to enable walk animation
var must_rotate # check only if it's moving to rotate mesh


func _ready():
	self.angle = atan2(translation.x, translation.z)

func _process(delta):
	pass

func set_center(new_center):
	self.rotation_center = new_center
	self.rotation_radius = self.global_transform.origin.distance_to(new_center)

func change_camera_parent():
	var par_dest = get_node("..")
	pass #todo

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	#var camera = $Target/Camera
	#var cam_xform = camera.get_global_transform()
	if (Input.is_action_pressed("move_left")):
		angle += delta * angularSpeed
	if (Input.is_action_pressed("move_right")):
		angle -= delta * angularSpeed
	
	# Testar também setar a posição manualmente
	var pos_before = self.global_transform.origin
	var pos_after = Vector3(rotation_center.x + rotation_radius * cos(angle),
		pos_before.y, rotation_center.z + rotation_radius * sin(angle))
	
	var pos_var = pos_after - pos_before
	
	# self.translate(pos_var)
	
	self.translation = pos_after
	
	velocity.y += gravity * delta
	velocity.x = 0
	velocity.z = 0
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = 10 #jump

	var hitCount = get_slide_count()

	if(hitCount > 0):
		var collision = get_slide_collision(0)
		if collision.collider is RigidBody:
			# collision.collider.apply_impulse(collision.position, -collision.normal)
			pass
	
	#HANDLING ANIMATION AND ROTATION
	#vou ter que mudar isso no futuro para pôr animação de pulo
	is_moving = (velocity.x or velocity.y or velocity.z != 0) #and !$CollisionShape/CharacterMesh/AnimationPlayer.is_playing()
	must_rotate = (velocity.x or velocity.y or velocity.z != 0)

	if must_rotate:
		var _angle = atan2(velocity.x, velocity.z)
		var char_rot = self.get_rotation()
		char_rot.y = _angle
		self.set_rotation(char_rot)
		
	#ANIMAÇÃO DE ANDAR
	if is_moving:
#		$CollisionShape/CharacterMesh/AnimationPlayer.play("default")
		pass