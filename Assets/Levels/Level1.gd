extends "res://Assets/GeneralScripts/LevelManager.gd"

const SURVIVAL_TIME = 10

func _ready():
	$LevelTimer.wait_time = SURVIVAL_TIME
	$LevelTimer.start()
	.start_level()

func _on_Gugu_died():
	.on_player_died()

func restart_level():
	.restart_level()
	$LevelTimer.wait_time = SURVIVAL_TIME
	$LevelTimer.start()

func _on_LevelTimer_timeout():
	print("Gugu won")