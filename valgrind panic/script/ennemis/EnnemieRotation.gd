extends Sprite

var target

func _onready():
	target = global_position.direction_to(get_node("/root/main/Base").position)
	
#func _process(delta):
	#rotation = position.angle_to(target)
