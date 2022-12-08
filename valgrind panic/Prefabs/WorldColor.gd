extends WorldEnvironment

onready var worldEnv = $".".get_environment().get_adjustment_color_correction().gradient
onready var defaultGradiant = preload("res://Light/DefaultGradiant.tres")
onready var blueGradiant = preload("res://Light/BlueGradiant.tres")
var gradiantNu = 2
var color = Color8(0,0,0)

func _ready():
	colorSwap(1)
	
func colorSwap(vague):

	#worldEnv.set_color(1, Color8 (164,219,232))
	pass
