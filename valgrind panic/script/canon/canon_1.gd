extends KinematicBody2D

var d = PI
var radius = 160
onready var hero = get_child(0)
onready var bullet = get_child(2)
var damage = 1
var speed = 2
var attackSpeed = 1
var bulletSpeed = 1
var rotatespeed = speed
var temp = 0
onready var mainFile = get_node("/root/main")

func movement(delta):
	#bullet.damage = damage
	#bullet.attackSpeed = attackSpeed
	#bullet.bulletSpeed = bulletSpeed
	if (Input.is_action_pressed("left") and position.x > ((-sqrt(3))/2) * radius + 960 and !Input.is_action_pressed("right") and mainFile.wichCanon == 1) or (Input.is_action_pressed("left2") and position.x > ((-sqrt(3))/2) * radius + 960 and !Input.is_action_pressed("right2") and mainFile.wichCanon2 == 1):
		d += speed * delta
		hero.rotation -= rotatespeed * delta
		if position.x < ((-sqrt(3))/2) * radius + 960 + speed: # + speed je sais pas d'ou ca sort
			temp = d
			d = 8 *PI / 6
			hero.rotation -= d - temp
	if (Input.is_action_pressed("right") and position.x < ((sqrt(3))/2) * radius + 960 and !Input.is_action_pressed("left") and mainFile.wichCanon == 1) or (Input.is_action_pressed("right2") and position.x < ((sqrt(3))/2) * radius + 960 and !Input.is_action_pressed("left2") and mainFile.wichCanon2 == 1):
		d -= speed * delta
		hero.rotation += rotatespeed * delta
		if position.x > ((sqrt(3))/2) * radius + 960 - speed: # - speed je sais pas d'ou ca sort
			temp = d			
			d = 4 * PI / 6
			hero.rotation -= d - temp
	position = Vector2(
		sin(d) * radius + 960,
		cos(d) * radius + 540
	)
