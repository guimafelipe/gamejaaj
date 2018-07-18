extends Spatial

func _ready():
	var center_pos = $Centro.global_transform.origin
	$Gugu.set_center(center_pos)
	$BasePivot.set_center(center_pos)
	$BasePivot.set_player($Gugu)