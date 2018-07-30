extends Node

func play_gnome_voice():
	var n = get_child_count()
	for i in range(n):
		get_child(i).stop()
	randomize()
	var i = randi() % n
	get_child(i).play()