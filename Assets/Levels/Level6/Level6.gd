extends Spatial

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		$PauseUI.show()