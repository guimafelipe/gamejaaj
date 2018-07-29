extends Button

export var LEVEL = 1
signal level_selected(level)

func _ready():
	set_disabled(GameState.max_level_reached < LEVEL && LEVEL != 1)
	connect("button_up", self, "send_level_info")

func send_level_info():
	emit_signal("level_selected", LEVEL)
