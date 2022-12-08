extends Node2D

var upgrade1 = preload("res://valgrind panic/Upgrades/Scene/AttackSpeed.tscn")
var upgrade2 = preload("res://valgrind panic/Upgrades/Scene/Damage.tscn")
var upgrade3 = preload("res://valgrind panic/Upgrades/Scene/BulletSpeed.tscn")

var upgradeTab = [upgrade1, upgrade2, upgrade3]
var chosenTab = []
var current = null

func is_not_in(upgrade):
	for i in chosenTab:
		if i == upgrade:
			return 1
	return 0

func chosen():
	if current == null:
		current = get_node("upgrade1")
	current.onClick()
	print("ici")
	get_node("/root/main").shopOpen = 0
	get_node("/root/main").finishShop = 0
	get_node("/root/main/spawnTimer").finVague = 0
	get_node("/root/main/spawnTimer").vague += 1
	get_node("/root/main/spawnTimer").start()

	queue_free()

func _ready():
	var rand
	while chosenTab.size() < 3:
		rand = randi() % upgradeTab.size()
		if not is_not_in(upgradeTab[rand]):
			chosenTab.append(upgradeTab[rand])
	#create Upgrade 1
	var currentUpgrade = chosenTab[0].instance()
	currentUpgrade.position.x = -313
	currentUpgrade.name = "upgrade1"
	$".".add_child(currentUpgrade)
	#create Upgrade 2
	currentUpgrade = chosenTab[1].instance()
	currentUpgrade.position.x = 0
	currentUpgrade.name = "upgrade2"
	$".".add_child(currentUpgrade)
	#create Upgrade 3
	currentUpgrade = chosenTab[2].instance()
	currentUpgrade.position.x = 313
	currentUpgrade.name = "upgrade3"
	$".".add_child(currentUpgrade)

func _process(_delta):
	if Input.is_action_just_pressed("left"):
		if current == null:
			current = get_node("upgrade1")
		else:
			current.modulate = "FFFFFF"
			if current.name == "upgrade3":
				current = get_node("upgrade2")
			elif current.name == "upgrade2":
				current = get_node("upgrade1")
		current.modulate = "111111"
	if Input.is_action_just_pressed("right"):
		if current == null:
			current = get_node("upgrade3")
		else:
			current.modulate = "FFFFFF"
			if current.name == "upgrade1":
				current = get_node("upgrade2")
			elif current.name == "upgrade2":
				current = get_node("upgrade3")
		current.modulate = "111111"
	if Input.is_action_just_pressed("enter"):
		chosen()
