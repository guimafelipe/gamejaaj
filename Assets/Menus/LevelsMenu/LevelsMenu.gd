extends MarginContainer

func _ready():
	for button in $HBoxContainer/Buttons.get_children():
		button.connect("level_selected", self, "on_level_selected")

func on_level_selected(level):
	print(level)