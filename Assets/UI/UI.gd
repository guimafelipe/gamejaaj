extends MarginContainer

func _ready():
	$SubtitlesUI.connect("subtitle_finished", self, "on_subtitle_finished")

func enter_cutscene():
	$PlayerUI.set_visible(false)
	$SurviveTimeUI.set_visible(false)
	$CountdownUI.set_visible(false)
	$SubtitlesUI.set_visible(true)
	$HBoxContainer.set_visible(true)

func enter_gameplay():
	$SurviveTimeUI.set_visible(true)
	$PlayerUI.set_visible(true)
	$CountdownUI.set_visible(true)
	$SubtitlesUI.set_visible(false)
	$HBoxContainer.set_visible(false)

func set_countdown_timer(timer):
	$CountdownUI.set_countdown_timer(timer)

func set_survive_timer(timer):
	$SurviveTimeUI.set_countdown_timer(timer)

func set_subtitle(text):
	$SubtitlesUI.set_subtitle(text)
	$HBoxContainer/NextButton.set_disabled(true)

func end_subtitles():
	$SubtitlesUI.end_subtitles()

func show_skip_button():
	$HBoxContainer/SkipButton.set_visible(true)

func _on_SkipButton_button_up():
	$HBoxContainer/SkipButton.set_visible(false)
	if(get_node("../Cutscene")):
		var animator = get_node("../Cutscene/CutsceneAnim")
		animator.seek(animator.current_animation_length - 0.5, true)

func on_subtitle_finished():
	$HBoxContainer/NextButton.set_disabled(false)

func _on_NextButton_button_up():
	if(get_node("../Cutscene")):
		var animator = get_node("../Cutscene/CutsceneAnim")
		var animation = animator.get_animation("Cutscene")
		var origin = animator.get_current_animation_position()
		var track_time
		origin = ((int(origin*10))/10)
		var t = origin
		while(t <= animation.length):
			var track_id = animation.track_find_key(0, t, true)
			if track_id > 0:
				track_time = t
				break
			t += animation.step
		if track_time:
			animator.seek(track_time, true)
	$HBoxContainer/NextButton.set_disabled(true)
	$HBoxContainer/NextButton.release_focus()
