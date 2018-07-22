extends Control

const sentence_begin = "Tempo restante: "
var timer
var in_countdown = false

func set_countdown_timer(timer):
	self.timer = timer
	in_countdown = true
	$TimeCounter.set_visible(true)
	$TimeCounter.set_text(sentence_begin + str(ceil(timer.get_wait_time())))
	timer.connect("timeout", self, "on_timer_timeout")

func on_timer_timeout():
	$TimeCounter.set_text(sentence_begin + "0")

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
	if(in_countdown and (not timer.is_stopped()) and (not timer.is_paused())):
		update_timer_ui(timer.time_left)
