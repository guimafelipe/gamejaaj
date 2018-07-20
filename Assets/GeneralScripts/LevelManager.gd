extends Spatial

onready var player = $Gugu
onready var cutscene_manager = $Cutscene
onready var center = $Ambient/Centro.global_transform.origin
onready var player_spawn = $PlayerSpawn.global_transform.origin

func _ready():
	player.set_center(center)
	$BasePivot.set_center(center)
	$BasePivot.set_player(player)

func restart_level():
	level_setup()

func restart_pointers():
	for pointer in $Ponteiros.get_children():
		pointer.restart_movement()

func level_setup():
	player.transform.origin = player_spawn
	player.reset_hp()
	restart_pointers()

func start_cutscene():
	cutscene_manager.start()

func cutscene_ended():
	pass
	# start game here

func on_player_died():
	pass
	#reset level here