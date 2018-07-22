extends Control

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