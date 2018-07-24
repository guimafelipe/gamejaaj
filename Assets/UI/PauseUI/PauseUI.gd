extends Control

func _on_ResumeBtn_button_up():
	hide()
	get_tree().paused = false

func _on_LevelSelectBtn_button_up():
	get_tree().paused = false
	SceneLoader.goto_levels_menu()

func _on_MainMenuBtn_button_up():
	get_tree().paused = false
	SceneLoader.goto_main_menu()
