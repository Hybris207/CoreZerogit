extends Sprite

func onClick():
	get_node("/root/main/canon_1").attackSpeed *= 1.1
	get_node("/root/main/canon_2").attackSpeed *= 1.1
	get_node("/root/main/canon_3").attackSpeed *= 1.1	
