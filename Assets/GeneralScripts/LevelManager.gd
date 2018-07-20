extends Node

onready var player = $Gugu
onready var cutscene_manager = $Cutscene
onready var center = $Ambient/Centro

func _ready():
	pass

func level_setup():
	# this vary level by level
	print('not implemented')

func start_cutscene():
	cutscene_manager.start()

func cutscene_ended():
	pass
	# start game here

func on_player_died():
	pass
	#reset level here