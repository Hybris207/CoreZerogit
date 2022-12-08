extends Node

onready var waveTime = get_child(2)
onready var canon_1 = get_child(3)
onready var canon_2 = get_child(4)
onready var canon_3 = get_child(5)
var shop = preload("res://valgrind panic/Upgrades/Scene/Shop.tscn")
var wichCanon = 0
var wichCanon2 = 0
var time = 1
var first = 0
var creatshop = 0
var finishShop = 0
var shopOpen = 0

func _ready():
	canon_1.movement(1)
	canon_2.movement(1)
	canon_3.movement(1)

func _process(delta):
	if finishShop == 0:
		if Input.is_action_pressed("center"):
			wichCanon = 0
		if Input.is_action_pressed("center2"):	
			wichCanon2 = 0		
		if Input.is_action_pressed("top") and wichCanon == 0:
			wichCanon = 1
		if Input.is_action_pressed("top2") and wichCanon2 == 0:
			wichCanon2 = 1		
		elif Input.is_action_pressed("right") and wichCanon == 0:
			wichCanon = 2
		elif Input.is_action_pressed("right2") and wichCanon2 == 0:		
			wichCanon2 = 2		
		elif Input.is_action_pressed("left") and wichCanon == 0:
			wichCanon = 3
		elif Input.is_action_pressed("left2") and wichCanon2 == 0:		
			wichCanon2 = 3
		if wichCanon == 1 or wichCanon2 == 1:
			canon_1.movement(delta)
		if wichCanon == 2 or wichCanon2 == 2:
			canon_2.movement(delta)
		if wichCanon == 3 or wichCanon2 == 3:
			canon_3.movement(delta)
		if waveTime.finVague == 1 and waveTime.sumAllStartWave == 0:
			var t = Timer.new()
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			finishShop = 1
			wichCanon = 0
			wichCanon2 = 0
			if shopOpen == 0:
				shopOpen = 1
				creatshop = shop.instance()
				add_child(creatshop)
