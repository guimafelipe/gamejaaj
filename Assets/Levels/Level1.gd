extends "res://Assets/GeneralScripts/LevelManager.gd"

func _on_Gugu_died():
	.on_player_died()

func _on_LevelTimer_timeout():
	print("Gugu won")