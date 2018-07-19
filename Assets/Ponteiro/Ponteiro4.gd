extends "res://Assets/Ponteiro/Ponteiro.gd"

### Ponteiro da cotação das meias roubadas

onready var animator = $AnimationPlayer
var old_angle

func _ready():
	old_angle = rotation.y
	start_move()

func start_move():
	randomize()
	var next_angle = (randf() - 0.5) * 360
	var next_duration = randi() % 6 + 1
	var next_pause = randi()%8 + 1
	var anim = animator.get_animation('Move')
	anim.length = next_duration + next_pause
	anim.track_remove_key(0, 1)
	anim.track_remove_key(0, 0)
	anim.track_insert_key(0, 0.0, Vector3(0, old_angle, 0), 6.0)
	anim.track_insert_key(0, next_duration, Vector3(0, old_angle + next_angle, 0), 1)
	old_angle += next_angle
	var oldvalue = anim.track_get_key_value(1, 0)
	anim.track_remove_key(1, 0)
	anim.track_insert_key(1, anim.length - anim.step, oldvalue, 1)
	animator.play("Move")