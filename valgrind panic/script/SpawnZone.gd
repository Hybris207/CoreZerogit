extends Timer
#prefabs de ennemi
var mob = preload("res://valgrind panic/Prefabs/ennemis/ClassicBug.tscn")
var mob1 = preload("res://valgrind panic/Prefabs/ennemis/FatOne.tscn")
#le nombre de vague qui devra etre exporter
var vague = 1
var currentvague = 0
#budget ennemi
var budget = 100
#creation des tableau avec ennemis
var tabmob = [[mob, 100, 20], [mob1, 0, 15]]
#creation instance
var creatinstance = 0
# alloue la ne nombre de mob et leurs taille
var numberEachMobWave = []
var budgetEachType = []
var budgetToUse = 0
var timeToWaitMonster = []
var sumAllStartWave = 0
#return si fin vague 1, a remmtre a 0 au debut de chaque vague
var finVague = 0
var waitTime = 0
#main fonction
func mobSpawning():
	var chooseMonster = 0
	var sumAllMonster = 0
	var knowTheMonster = 0
	var typeToSpawn = 0
	var findPose = 0
	# calcule le nombre total de mob a pop
	for p in range(numberEachMobWave.size()):
		sumAllMonster += numberEachMobWave[p]
	# return si fin vague
	if sumAllMonster == 0:
		budgetEachType = []
		timeToWaitMonster = []
		numberEachMobWave = []
		budget = 100 + (vague) * 30
		finVague = 1
		return
	chooseMonster = rand_range(0, sumAllMonster)
	# fonction qui determine le type de mob a pop
	while knowTheMonster == 0:
		findPose += numberEachMobWave[typeToSpawn]
		if chooseMonster < findPose:
			knowTheMonster = 1
		typeToSpawn += 1
	# -1 pour re equilibrer
	typeToSpawn -= 1
	# variable compteur
	var i = 0
	var j = 0
	var k = 0
	var startmobspawn = 0
	# regarde a partir de quelle ennemie il faudra afficher
	while tabmob[startmobspawn][1] == 0:
			startmobspawn += 1
	while tabmob[i][1] == 0:
		i += 1
	k = i
	# s'execute une fois au debut de chaque vague
	if vague != currentvague:
		sumAllStartWave = sumAllMonster
		currentvague = vague
		budgetToUse = 0
		# permet de compter le budget utiliser pour chaque type et le total du budget utiliser precis
		while j < numberEachMobWave.size():
			budgetEachType.append(tabmob[i][2] * numberEachMobWave[j])
			budgetToUse += tabmob[i][2] * numberEachMobWave[j]
			j += 1
			i += 1
		# calcule du temps de repop pour chaque type d'ennemis
		j = 0
		while j < numberEachMobWave.size()and j < vague:
			timeToWaitMonster.append(((budgetEachType[j] / float(budgetToUse)) / float(numberEachMobWave[j])) * 5)
			j += 1	
	# supprime le mob qui a ete cree du nombre de son type
	numberEachMobWave[typeToSpawn] -= 1
	creatinstance = tabmob[k + typeToSpawn][0]
	wait_time = timeToWaitMonster[typeToSpawn]
	get_node("/root/main/spawnTimer").start()

func noHardCodeWave():
	var startmobspawn = 0
	var pourcentChange = 0.25
	var i = 0
	# s'execute seulement une fois au debut de la vague
	if vague != currentvague:
		# avacner au premier mob qui existe
		while tabmob[startmobspawn][1] == 0:
			startmobspawn += 1
		# donne le pourcenatge de budget qu'aura chaque mob
		numberEachMobWave = []
		i += startmobspawn
		while i < vague - 1 && i + 1 < tabmob.size():
			tabmob[i + 1][1] += pourcentChange * tabmob[i][1]
			tabmob[i][1] = (1 - pourcentChange) * tabmob[i][1]
			#elimine les mobs avec un trop faibble pourcentage
			if tabmob[i][1] < 25 and (i == 0 or tabmob[i - 1][1] == 0):
				tabmob[i + 1][1] += tabmob[i][1]
				tabmob[i][1] = 0
			i += 1
			startmobspawn = 0
		# re avacner au premier mob qui existe
		while tabmob[startmobspawn][1] == 0:
			startmobspawn += 1
		i = 0
		# calcule du nombre de chaque mob
		while i < vague and i < tabmob.size() - startmobspawn:
			numberEachMobWave.append(int(tabmob[i + startmobspawn][1] * (budget / 100.0)) / tabmob[i + startmobspawn][2])
			# met au moins un mob si il y a du pourcentage
			if numberEachMobWave[i] < 1:
				numberEachMobWave[i] = 1
			i += 1
	#if (vague % 5) != 0:
	mobSpawning()

func mobSpawningManual(numberEachMobWave2, tabmob2):
	var chooseMonster = 0
	var sumAllMonster = 0
	var knowTheMonster = 0
	var typeToSpawn = 0
	var findPose = 0
	# calcule le nombre total de mob a pop
	for p in range(numberEachMobWave2.size()):
		sumAllMonster += numberEachMobWave2[p]
	# return si fin vague
	if sumAllMonster == 0:
		budget = 100 + (vague - 1) * 30
		vague += 1
		#finVague = 1
		return
	chooseMonster = rand_range(0, sumAllMonster)
	# fonction qui determine le type de mob a pop
	while knowTheMonster == 0:
		findPose += numberEachMobWave2[typeToSpawn]
		if chooseMonster < findPose:
			knowTheMonster = 1
		typeToSpawn += 1
	# -1 pour re equilibrer
	typeToSpawn -= 1
	# variable compteur
	var i = 0
	var j = 0
	var k = 0
	# regarde a partir de quelle ennemie il faudra afficher
	while tabmob2[i][1] == 0:
		i += 1
	k = i
	# s'execute une fois au debut de chaque vague
	if vague != currentvague:
		currentvague = vague
		j = 0
		while j < numberEachMobWave.size():
			timeToWaitMonster.append(tabmob2[j][2])
			j += 1	
	# supprime le mob qui a ete cree du nombre de son type
	numberEachMobWave[typeToSpawn] -= 1
	creatinstance = tabmob[k + typeToSpawn][0]
	#wait_time = timeToWaitMonster[typeToSpawn]
	var t = Timer.new()
	t.set_wait_time(timeToWaitMonster[typeToSpawn])
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

func ManuelWave():
	# pour tout de meme faire tourner l'algo de pourcentage
	noHardCodeWave()
	if vague == 5:
		return

func ifSpecialWave():
	#if vague % 5 == 0:
		#ManuelWave()
	noHardCodeWave()
	
func _ready():
	randomize()

func _on_Timer_timeout():
	# return si fin vague
	if finVague == 1:
		return
	ifSpecialWave()
	# return si fin vague peut etre inutile
	if finVague == 1:
		return
	wait_time = 3
	# cree l'instance selectionne avant
	var mobcreat = creatinstance.instance()
	var spawnX = 0
	var spawnY = 0
	var whereInTopBottom = 0
	# determine sur quelle cote le mob va pop
	var line = rand_range(0, 4)
	# determine ou sur le cote en question il va pop
	if line <=  1:
		whereInTopBottom = randi() % 5
		if whereInTopBottom <= 1:
			spawnX = rand_range(-50, 770)
		elif whereInTopBottom == 2:
			spawnX = rand_range(770, 1200)
		elif whereInTopBottom <= 4:
			spawnX = rand_range(1200, 2020)
		spawnY = -50
	elif line <= 2:
		whereInTopBottom = randi() % 5
		if whereInTopBottom <= 1:
			spawnX = rand_range(-50, 770)
		elif whereInTopBottom == 2:
			spawnX = rand_range(770, 1200)
		elif whereInTopBottom <= 4:
			spawnX = rand_range(1200, 2020)
		spawnY = 1120
	elif line <= 3:
		spawnX = -50
		spawnY = rand_range(-50, 1120)
	elif line <= 4:
		spawnY = rand_range(-50, 1120)
		spawnX = 2020	
	# assignation des pos et spawn du mob
	mobcreat.position = Vector2(spawnX, spawnY)
	add_child(mobcreat)
