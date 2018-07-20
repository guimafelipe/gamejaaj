extends "res://Assets/Ponteiros/PonteiroBase/Ponteiro.gd"

var player
var curr_angle
var animator

func _ready():
	animator = $PonteiroMov
	player = get_node("../Gugu")
	start_move()

func start_move():
	if(player == null):
		return;
	var player_pos = player.global_transform.origin
	player_pos.y = global_transform.origin.y
	var midle_transform = global_transform.looking_at(player_pos, UP)
	var desired_transform = global_transform.interpolate_with(midle_transform, 1.7)
	var anim = animator.get_animation('Move')
	anim.track_set_key_value(0, 0, global_transform)
	anim.track_set_key_value(0, 1, midle_transform)
	anim.track_set_key_value(0, 2, desired_transform)
	animator.play("Move")