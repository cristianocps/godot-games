extends Node2D

export var _speed = -400
var scene

func _ready():
	set_process(true)
	scene = get_tree().current_scene

func _process(delta):
	if scene.state == scene.PLAYING:
		position += Vector2(_speed*delta,0)
		if position.x <=- 100:
			print_debug("destruiu o cano")
			queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().current_scene.kill()


func _on_Score_body_entered(body):
	if body.name == "Player":
		get_tree().current_scene.score_point();
