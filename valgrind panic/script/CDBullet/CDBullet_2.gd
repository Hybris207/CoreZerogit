extends Timer


var bullet = preload("res://valgrind panic/Prefabs/Bullet.tscn")
onready var main = get_node("/root/main")
var attackSpeed = 1
var time = 0.5
var start = 0
var damage = 1.0
var bulletSpeed = 1

func _on_CDBullet_timeout():
	time = 0.5 / attackSpeed
	if start == 1:
		wait_time = time
	if main.wichCanon == 2 or main.wichCanon2 == 2:
		var instancing = bullet.instance()
		var creatBullet = instancing
		creatBullet.speed = bulletSpeed
		creatBullet.damage = damage
		creatBullet.position = Vector2(get_node("/root/main/canon_2").position.x, get_node("/root/main/canon_2").position.y)
		add_child(creatBullet)
		wait_time = time
	if start < 2:
		start += 1
