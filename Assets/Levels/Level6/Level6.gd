extends Spatial

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		$PauseUI.show()

func on_end_cutscene():
	SceneLoader.goto_credits()

func play_door():
	AudioManager.play_sound("Door")

func play_footsteps():
	AudioManager.play_sound("Footsteps")

func play_poof():
	AudioManager.play_sound("Poof")