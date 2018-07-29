extends Node

var loader
var wait_frames
var time_max = 100
var current_scene

var is_level = false

var levels_loading_texts = [
	"Ezequiel, o Gnomo das Horas",
	"Zequinha, o Gnomo da Bússola",
	"Evilásio, o Gnomo das Meias",
	"Wesley, o Gnomo do Pêndulo",
	"Moacir, o Gnomo Chefe",
	"Humano, o Humano",
]

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	if not is_level:
		$Margin/Label.set_text("Loading...")
	
	$Margin.set_modulate(Color(1,1,1,1))
	
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		show_error()
		return
	set_process(true)
	
	current_scene.queue_free()
	
	$ColorRect.set_visible(true)
	$Margin.set_visible(true)
	#$LoadAnimation.play("Loading")
	
	wait_frames = 1

func _process(delta):
	if loader == null:
		# pode dar merda
		set_process(false)
		return
	
	if wait_frames > 0:
		wait_frames = -1
		return
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max:
		var err = loader.poll()
		
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			#update_progress()
			pass
		else:
			show_error()
			loader = null
			break

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node('/root').add_child(current_scene)
	if is_level:
		$AnimationPlayer.play("FadeOutLevels")
		is_level = false
	else:
		$Margin.set_visible(false)
	$ColorRect.set_visible(false)

func goto_level(level):
	if(level == 7):
		goto_credits()
		return
	var level_path = "res://Assets/Levels/Level" + str(level) + "/Level" \
	 + str(level) + ".tscn"
	$Margin/Label.set_text(levels_loading_texts[level-1])
	is_level = true
	goto_scene(level_path)

func goto_levels_menu():
	goto_scene("res://Assets/Menus/LevelsMenu/LevelsMenu.tscn")

func goto_main_menu():
	goto_scene("res://Assets/Menus/MainMenu/MainMenu.tscn")

func goto_credits():
	goto_scene("res://Assets/Menus/Credits/Credits.tscn")