extends Node

func _ready():
	$Hurt.stream.set_loop(false)
	pass

func play_background_music():
	if $BackgroundMusic.playing:
		return
	$BackgroundMusic.stream.set_loop(true)
	$BackgroundMusic.play()

func stop_background_music():
	$BackgroundMusic.stop()

func play_background_cutscene():
	$BackgroundCutscene.stream.set_loop(true)
	$BackgroundCutscene.play()

func stop_background_cutscene():
	$BackgroundCutscene.stop()

func play_sound(name):
	var toplay = get_node(name)
	if toplay:
		toplay.play()

func play_gnome_voice():
	$FalasGnomo.play_gnome_voice()