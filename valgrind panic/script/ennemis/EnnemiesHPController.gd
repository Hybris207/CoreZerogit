extends Area2D

onready var baseHP = get_parent().baseHP

func gotHit(dmg):
	baseHP -= dmg
	if baseHP <= 0:
		get_node("/root/main/spawnTimer").sumAllStartWave -= 1
		get_parent().queue_free()
