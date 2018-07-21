extends Spatial

const Player = preload('res://Assets/Gugu/Gugu.gd')
const UP = Vector3(0,1,0)

#Basta herdar dessa classe e mudar as constantes
const angular_speed = 2*PI/3
const dmg = 1

func _ready():
	initial_setup()

func initial_setup():
	restart_movement()

func stop_movement():
	if($PonteiroMov):
		$PonteiroMov.stop(false)

func restart_movement():
	if($PonteiroMov):
		$PonteiroMov.stop(true)
		$PonteiroMov.play("Idle")

func _on_Area_body_entered(body):
	if(body is Player):
		body.take_damage(dmg)
