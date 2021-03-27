extends Node2D

onready var _barrelAnimation = get_node("AnimationPlayer")
func _ready():
	pass # Replace with function body.
func destroy(direction):
	if direction == -1:
		_barrelAnimation.play("barrel_right")
	else:
		_barrelAnimation.play("barrel_left")
	
	

