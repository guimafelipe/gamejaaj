extends Node

func _ready():
	$Hurt.stream.set_loop(false)
	pass

func play_background_music():
	$BackgroundMusic.play()

func stop_background_music():
	$BackgroundMusic.stop()

func play_sound(name):
	var toplay = get_node(name)
	if toplay:
		toplay.play()