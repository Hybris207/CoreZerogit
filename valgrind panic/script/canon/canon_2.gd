extends KinematicBody2D

var d = 2 * PI/6
var radius = 160
onready var hero = get_child(0)
onready var bullet = get_child(2)
var damage = 1
var speed = 2
var attackSpeed = 1
var rotatespeed = speed
var bulletSpeed = 1
var temp = 0
onready var mainFile = get_node("/root/main")

func _ready():
	hero.rotation = -10.47

func movement(delta):
	if (Input.is_action_pressed("right") and position.x > 960 and !Input.is_action_pressed("left") and mainFile.wichCanon == 2) or (Input.is_action_pressed("right2") and position.x > 960 and !Input.is_action_pressed("left2") and mainFile.wichCanon2 == 2): # position.y < radius / 2
		d -= speed * delta
		hero.rotation += rotatespeed * delta
		if sin(d) * radius < 0:
			temp = d
			d = 2*PI
			hero.rotation -= d - temp
	if (Input.is_action_pressed("left") and position.y > -radius / 2 + 540 and !Input.is_action_pressed("right") and mainFile.wichCanon == 2) or (Input.is_action_pressed("left2") and position.y > -radius / 2 + 540 and !Input.is_action_pressed("right2") and mainFile.wichCanon2 == 2):
		d += speed * delta
		hero.rotation -= rotatespeed * delta
		if cos(d) * radius < -radius / 2:
			temp = d
			d = 4*PI / 6
			hero.rotation -= d - temp
	position = Vector2(
		sin(d) * radius + 960,
		cos(d) * radius + 540
	)
