extends KinematicBody2D

export var speed = 50
var baseHP = 2
onready var time = get_node("/root/main").time
onready var target = global_position.direction_to(get_node("/root/main/Base").position)

func _ready():
	rotateToward()
	
func rotateToward():
	var angle = $Sprite.transform.x.angle_to(target) + PI / 2
	$Sprite.rotate(angle)

func _process(delta):
	target = global_position.direction_to(get_node("/root/main/Base").position)
	position += Vector2(target.x * speed * delta * time, target.y * speed * delta * time)
