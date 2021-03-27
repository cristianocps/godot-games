extends RigidBody2D
onready var _flySound = get_node("FlySound")


func _ready():
	set_process_input(true)
	_flySound.stream.set_loop(false)

func _input(event):
	if event.is_action_pressed("touch"):
		on_touch()
			
func on_touch():
	_flySound.play()
	apply_impulse(Vector2(0,0),Vector2(0,-1000))
