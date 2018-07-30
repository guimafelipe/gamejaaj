extends MarginContainer

func _ready():
	AudioManager.play_background_menu()
	for button in $HBoxContainer/Buttons.get_children():
		button.connect("level_selected", self, "on_level_selected")

func on_level_selected(level):
	SceneLoader.goto_level(level)

func _on_BackBtn_button_up():
	SceneLoader.goto_main_menu()
