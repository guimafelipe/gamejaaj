extends Control

func set_subtitle(text):
	$SubtitlesAnimator.stop(true)
	$SubtitlesUI.set_percent_visible(0)
	$SubtitlesUI.set_text(text)
	if subtitle_check(text):
		AudioManager.play_gnome_voice()
	$SubtitlesAnimator.play("ShowSubs")

func start_subtitles():
	$SubtitlesUI.set_visible(true)

func end_subtitles():
	$SubtitlesUI.set_visible(false)

func end_cutscene():
	$SubtitlesUI.set_visible(false)

func subtitle_check(text):
	var allowed = ['.', '*']
	for el in allowed:
		if text.begins_with(el):
			return false
	return true