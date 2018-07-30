extends Control

func _ready():
	AudioManager.play_background_menu()

func _on_BackButton_button_up():
	SceneLoader.goto_main_menu()
