extends "res://Assets/GeneralScripts/LevelManager.gd"

func _ready():
	restart_pointers()

func _on_Gugu_died():
	restart_level()
