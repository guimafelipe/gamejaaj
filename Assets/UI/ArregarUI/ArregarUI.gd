extends MarginContainer

signal arregou

func _on_ArregarBtn_button_up():
	emit_signal("arregou")
	$ArregarBtn.release_focus()

func deactivate_btn():
	$ArregarBtn.set_disabled(true)
