extends Spatial

onready var player = $Gugu
onready var center = $Ambient/Centro.global_transform.origin
onready var player_spawn = $PlayerSpawn.global_transform.origin

# Timers
onready var countdown_timer = $Timers/CountdownTimer
onready var level_timer = $Timers/LevelTimer
onready var winanim_timer = $Timers/WinAnimTimer
onready var loseanim_timer = $Timers/LoseAnimTimer

const SURVIVAL_TIME = 30
export var LEVEL = 1

func _ready():
	# This node has all below dependencies to work
	start_level()
	player.set_center(center)
	$BasePivot.set_center(center)
	$BasePivot.set_player(player)
	connect_timers()
	player.connect("died", self, "on_player_died")

func connect_timers():
	countdown_timer.connect("timeout", self, "on_countdown_ended")
	level_timer.connect("timeout", self, "level_win")
	level_timer.set_wait_time(SURVIVAL_TIME)
	winanim_timer.connect("timeout", self, "on_win_anim_ended")
	loseanim_timer.connect("timeout", self, "on_lose_anim_ended")

func start_level():
	# call only once per level play
	print(GameState.max_level_reached)
	start_cutscene()

func restart_level():
	level_setup()
	countdown_timer.start()
	$UI.set_countdown_timer(countdown_timer)
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
	$UI.enter_cutscene()
	$Cutscene/CutsceneAnim.play("Cutscene")
	
	$UI.show_skip_button()
	GameState.set_max_level_reached(LEVEL)

func on_cutscene_ended():
	$Cutscene/CutsceneAnim.stop()
	$UI.enter_gameplay()
	restart_level()

func level_win():
	player.can_move = false
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()
	winanim_timer.start()
	# call next level

func on_player_died():
	level_timer.stop()
	for pointer in $Ponteiros.get_children():
		pointer.stop_movement()
	# wait 2 seconds maybe
	loseanim_timer.start()

func on_countdown_ended():
	restart_pointers()
	player.liberate_movement()
	level_timer.start()
	$UI.set_survive_timer(level_timer)

func on_lose_anim_ended():
	restart_level()

func on_win_anim_ended():
	print("win anim ended")
	SceneLoader.goto_level(LEVEL + 1)

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		$PauseUI.show()