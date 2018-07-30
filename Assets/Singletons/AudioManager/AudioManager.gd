extends Node

func _ready():
	pass

func play_hurt():
	$Hurt.play()

func play_jump():
	$Jump.play()

func play_footsteps():
	$FootSteps.play()

func play_door():
	$Door.play()

func play_background_music():
	$BackgroundMusic.play()

func stop_background_music():
	$BackgroundMusic.stop()