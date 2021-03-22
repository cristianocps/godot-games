extends Position2D

onready var pipe = preload("res://scenes/Cano.tscn")


func _ready():
	randomize()

func _on_Timer_timeout():
	var new_pipe = pipe.instance()
	new_pipe.position = position+Vector2(0,rand_range(-500,500))
	owner.add_child(new_pipe)
	print_debug("gerou cano")
