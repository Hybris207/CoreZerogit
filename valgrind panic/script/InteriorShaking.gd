extends Sprite

onready var sprite = global_position
var baseP
var shakingSpeed = 30
onready var timerShaking = $ShakingCore

func _ready():
	timerShaking.start(1)
	
func _physics_process(delta):
	global_position.x += rand_range(-1, 1) * shakingSpeed * delta
	global_position.y += rand_range(-1, 1) * shakingSpeed * delta

func _on_ShakingCore_timeout():
	global_position.x = sprite.x
	global_position.y = sprite.y
	timerShaking.start(1)
