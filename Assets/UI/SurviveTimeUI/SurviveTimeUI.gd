extends Control

const sentence_begin = "Tempo restante: "
var timer
var in_countdown = false

func set_countdown_timer(timer):
	self.timer = timer
	in_countdown = true
	$TimeCounter.set_visible(true)
	$TimeCounter.set_text(sentence_begin + str(ceil(timer.wait_time)))

func update_timer_ui(value):
	var current = $TimeCounter.text.to_int()
	if(ceil(value) == current):
		return 
	if(value == 0):
		$TimeCounter.set_visible(false)
		in_countdown = false
	else:
		$TimeCounter.set_visible(true)
	$TimeCounter.set_text(sentence_begin + str(ceil(value)))

func _process(delta):
	if(in_countdown):
		update_timer_ui(timer.time_left)