extends KinematicBody

# Constants for better code
const RIGHT = 1
const LEFT = -1

# Variables related to movimentation
var speed = 500
var direction = Vector3()
var angle = 0
var angularSpeed = 2*PI/6 
var rotation_center
var rotation_radius
var gravity = -9.8
var velocity = Vector3()
var pos_after
var pos_before

var must_rotate # check only if it's moving to rotate mesh

# Variables related to player state
const MAX_HP = 3
var lifes = 3
var invulnerable = false
signal died
signal lifes_update(lifes)

# Variables for game flow control
var can_move = false

func _ready():
	self.angle = atan2(translation.x, translation.z)
	reset_hp()

func reset_position(spawn_position):
	transform.origin = spawn_position
	self.angle = atan2(translation.x, translation.z)
	set_center(rotation_center)
	$GuguMesh/AnimationPlayer.play("Idle")
	$EffectsPlayer.play("Idle")

# Hp fuctions
func reset_hp():
	set_hp(MAX_HP)

func set_hp(value):
	if(value >= 0):
		self.lifes = value
		emit_signal("lifes_update", lifes)

func take_damage(value):
	if invulnerable: return
	if(value >= 0 and lifes > 0):
		lifes = max(0, lifes - value)
		AudioManager.play_sound("Hurt")
		if(lifes == 0):
			can_move = false
			# Play death animation here
			$GuguMesh/AnimationPlayer.stop()
			$EffectsPlayer.play("DeathAnim")
			emit_signal('died')
		else:
			start_invulnerability()
		emit_signal("lifes_update", lifes)

func liberate_movement():
	start_invulnerability()
	can_move = true

func start_invulnerability():
	$EffectsPlayer.play("OnDamage")
	invulnerable = true

func remove_invulnerability():
	invulnerable = false

# Player movimentation
func set_center(new_center):
	self.rotation_center = new_center
	self.rotation_radius = self.global_transform.origin.distance_to(new_center)

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	#var camera = $Target/Camera
	#var cam_xform = camera.get_global_transform()
	var old_angle = angle
	if (can_move and Input.is_action_pressed("move_left")):
		angle -= delta * angularSpeed
	if (can_move and Input.is_action_pressed("move_right")):
		angle += delta * angularSpeed
	
	# Testar também setar a posição manualmente
	pos_before = self.global_transform.origin
	pos_after = Vector3(rotation_center.x + rotation_radius * sin(angle),
		pos_before.y, rotation_center.z + rotation_radius * cos(angle))
	
	velocity.y += gravity * delta
	if(angle != old_angle):
		var pos_var = pos_after - pos_before
		velocity.x = pos_var.x/delta
		velocity.z = pos_var.z/delta
	else:
		velocity.x = 0
		velocity.z = 0
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	# HANDLING ANIMATION
	if can_move and is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = 10 #jump
		$GuguMesh/AnimationPlayer.play("Jump")
		AudioManager.play_sound("Jump")
	elif (not $GuguMesh/AnimationPlayer.is_playing()):
		if(velocity.x or velocity.z != 0):
			$GuguMesh/AnimationPlayer.play("Walk")
		else:
			$GuguMesh/AnimationPlayer.stop(true)
			$GuguMesh/AnimationPlayer.play("Idle")
	elif($GuguMesh/AnimationPlayer.get_current_animation() == "Walk"):
		if(velocity.length() <= 0.1):
			$GuguMesh/AnimationPlayer.stop(true)
			$GuguMesh/AnimationPlayer.play("Idle")
	
	#HANDLING ROTATION
	must_rotate = (velocity.x or velocity.z != 0)
	
	if must_rotate:
		var _angle = atan2(velocity.x, velocity.z)
		var char_rot = self.get_rotation()
		char_rot.y = _angle
		self.set_rotation(char_rot)
	
	