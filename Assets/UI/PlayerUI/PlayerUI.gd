extends Control

const MAXLIFES = 3

func set_lifes(value):
	for i in range(MAXLIFES):
		var life = $LifesContainer.get_child(i)
		if i < value:
			life.set_visible(true)
		else:
			life.set_visible(false)

func _on_Gugu_lifes_update(lifes):
	set_lifes(lifes)
