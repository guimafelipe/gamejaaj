extends Spatial

onready var player = $Gugu
onready var cutscene_manager = $Cutscene
onready var center = $Ambient/Centro.global_transform.origin
onready var player_spawn = $PlayerSpawn.global_transform.origin

func _ready():
	player.set_center(center)
	$BasePivot.set_center(center)
	$BasePivot.set_player(player)

func start_level():
	# 3 seconds countdown here
	restart_pointers()
	player.liberate_movement()

func restart_level():
	level_setup()
	# 3 seconds countdown here
	player.liberate_movement()

func restart_pointers():
	for pointer in $Ponteiros.get_children():
		pointer.restart_movement()

func level_setup():
	player.reset_position(player_spawn)
	player.reset_hp()
	restart_pointers()

func start_cutscene():
	cutscene_manager.start()

func level_win():
	player.can_move = false
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()

func cutscene_ended():
	pass
	# start game here

func on_player_died():
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()
	# wait 2 seconds maybe
	#reset level here
	restart_level()