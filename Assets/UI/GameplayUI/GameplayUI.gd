extends Control

var timer
var in_countdown = false

# SUBTITLES
func set_subtitle(text):
	$SubtitlesAnimator.stop(true)
	$SubtitlesUI.set_percent_visible(0)
	$SubtitlesUI.set_text(text)
	$SubtitlesAnimator.play("ShowSubs")

func start_subtitles():
	$SubtitlesUI.set_visible(true)

func end_subtitles():
	$SubtitlesUI.set_visible(false)

func end_cutscene():
	$SubtitlesUI.set_visible(false)

#COUNTDOWN
func set_countdown_timer(timer):
	self.timer = timer
	in_countdown = true
	$CountdownUI.set_visible(true)
	$CountdownUI.set_text(str(ceil(timer.wait_time)))
	$CountdownAnimator.play("Countdown")

func update_timer_ui(value):
	var current = $CountdownUI.text.to_int()
	if(ceil(value) == current):
		return 
	if(value == 0):
		$CountdownUI.set_visible(false)
		in_countdown = false
	else:
		$CountdownUI.set_visible(true)
	$CountdownUI.set_text(str(ceil(value)))
	$CountdownAnimator.play("Countdown")

func _process(delta):
	if(in_countdown):
		update_timer_ui(timer.time_left)