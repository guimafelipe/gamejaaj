extends Control

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

func set_countdown_timer(timer):
	$CountdownUI.set_countdown_timer(timer)

func set_survive_timer(timer):
	$SurviveTimeUI.set_countdown_timer(timer)