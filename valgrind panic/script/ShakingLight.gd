extends Light2D

onready var Big = $OnMakesYouBig
onready var Small = $OnMakesYouSmall

var intensity = $".".energy
var size = $".".texture_scale

func _on_OnMakesYouBig_timeout():
	energy += 1
	size += 1
	Small.start(0.1)


func _on_OnMakesYouSmall_timeout():
	energy -= 1
	size -= 1
	Big.start(0.1)
