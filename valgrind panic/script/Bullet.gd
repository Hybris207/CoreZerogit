extends KinematicBody2D

var Direction = Vector2 (100,0)
export var hborder = 1920
export var vborder = 1080
onready var numberPlayer = get_node("/root/main")
export var speed = 1
var target
var shootAngle
var damage = 1.0

func _ready():
	target = get_node("/root/main/Base").position
	shootAngle = global_position.angle_to_point(target)
# warning-ignore:return_value_discarded
	$Area2D.connect("area_entered", self, "collide")

func _physics_process(delta):
	#print("e", speed)
	#print("y", damage)
	position += Direction.rotated(shootAngle) * delta * speed * 4
	if position.x > hborder or position.x < 0 or position.y > vborder or position.y < 0:
		queue_free()

func collide(hit):
	if hit.name == "EnnemiesHitBox":
		if numberPlayer.wichCanon == numberPlayer.wichCanon2:
			hit.gotHit(5 * damage)
		else:
			hit.gotHit(damage)
		queue_free()
