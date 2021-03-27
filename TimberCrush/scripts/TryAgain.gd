extends Node2D

onready var _animationPlayer = get_node("AnimationPlayer")
signal try_again

func _ready():
	pass # Replace with function body.
func start_animation():
	_animationPlayer.play("ShowButtonAnimation")


func _on_TryAgainButton_pressed():
	emit_signal("try_again")
