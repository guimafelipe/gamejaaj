extends MarginContainer

func enter_cutscene():
	$PlayerUI.set_visible(false)
	$SurviveTimeUI.set_visible(false)
	$CountdownUI.set_visible(false)
	$SubtitlesUI.set_visible(true)

func enter_gameplay():
	$SurviveTimeUI.set_visible(true)
	$PlayerUI.set_visible(true)
	$CountdownUI.set_visible(true)
	$SubtitlesUI.set_visible(false)
	$SkipButton.set_visible(false)

func set_countdown_timer(timer):
	$CountdownUI.set_countdown_timer(timer)

func set_survive_timer(timer):
	$SurviveTimeUI.set_countdown_timer(timer)

func set_subtitle(text):
	$SubtitlesUI.set_subtitle(text)

func end_subtitles():
	$SubtitlesUI.end_subtitles()

func show_skip_button():
	$SkipButton.set_visible(true)

func _on_SkipButton_button_up():
	$SkipButton.set_visible(false)
	if(get_node("../Cutscene")):
		var animator = get_node("../Cutscene/CutsceneAnim")
		animator.seek(animator.current_animation_length - 0.5, true)
