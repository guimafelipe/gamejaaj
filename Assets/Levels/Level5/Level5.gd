extends "res://Assets/GeneralScripts/LevelManager.gd"

const SURVIVAL_TIME = 25

const MAX_ARREGOS = 3
const MINDEATHSTOARREGO = 1

var death_count = 0
var arregos = 0

func _ready():
	$Gugu.connect("died", self, "increase_death_count")
	$ArregarUI.connect("arregou", self, "on_arrego")

func increase_death_count():
	death_count+=1
	if(death_count >= MINDEATHSTOARREGO):
		$ArregarUI.set_visible(true)

func on_arrego():
	$Ponteiros.get_child(0).queue_free()
	arregos+=1
	if(arregos >= MAX_ARREGOS):
		$ArregarUI.deactivate_btn()
		return