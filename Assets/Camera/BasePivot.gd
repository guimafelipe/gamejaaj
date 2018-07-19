extends Spatial

var center_pos
var player
const UP = Vector3(0,1,0)

func _ready():
	pass

func set_center(new_center):
	self.center_pos = new_center
	if($BaseCamPos/Camera):
		$BaseCamPos/Camera.set_center(new_center)

func set_player(new_player):
	player = new_player

func _physics_process(delta):
	if(player):
		var player_pos = player.transform.origin
		var new_pos = player_pos
		new_pos.y = self.translation.y
		self.translation = new_pos
	if(center_pos != null):
		look_at(center_pos, UP)