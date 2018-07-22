extends Spatial

onready var player = $Gugu
onready var center = $Ambient/Centro.global_transform.origin
onready var player_spawn = $PlayerSpawn.global_transform.origin

func _ready():
	# This node has all below dependencies to work
	player.set_center(center)
	$BasePivot.set_center(center)
	$BasePivot.set_player(player)
	$CountdownTimer.connect("timeout", self, "on_countdown_ended")
	$LevelTimer.connect("timeout", self, "level_win")
	$WinAnimTimer.connect("timeout", self, "on_win_anim_ended")
	$LoseAnimTimer.connect("timeout", self, "on_lose_anim_ended")
	player.connect("died", self, "on_player_died")
	start_level()

func start_level():
	# call only once per level play
	start_cutscene()

func restart_level():
	level_setup()
	$CountdownTimer.start()
	$UI/GameplayUI.set_countdown_timer($CountdownTimer)	
	# 3 seconds countdown here

func restart_pointers():
	for pointer in $Ponteiros.get_children():
		pointer.restart_movement()

func level_setup():
	player.reset_position(player_spawn)
	player.reset_hp()
	for pointer in $Ponteiros.get_children():
		pointer.reset_position()

func start_cutscene():
	$Cutscene/CutsceneAnim.play("Cutscene")

func on_cutscene_ended():
	$Cutscene/CutsceneAnim.stop()
	level_setup()
	$CountdownTimer.start()
	$UI/GameplayUI.set_countdown_timer($CountdownTimer)

func level_win():
	player.can_move = false
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()
	$WinAnimTimer.start()
	# call next level

func cutscene_ended():
	pass
	# start game here

func on_player_died():
	$LevelTimer.stop()
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()
	# wait 2 seconds maybe
	$LoseAnimTimer.start()

func on_countdown_ended():
	restart_pointers()
	player.liberate_movement()
	$LevelTimer.start()

func on_lose_anim_ended():
	restart_level()

func on_win_anim_ended():
	print("win anim ended")