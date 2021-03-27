extends Node2D

onready var _idle = get_node("Idle")
onready var _attacking = get_node("Attacking")
onready var _animation = get_node("AttackAnimation")
onready var _dead = get_node("Dead")

var _side = LEFT

const LEFT = -1
const RIGHT = 1


func _ready():
	pass # Replace with function body.

func left():
	position =  Vector2(220,1070)
	_idle.flip_h = false
	_attacking.flip_h=false
	
	_dead.position = Vector2(-44,41)
	_dead.flip_h=true
	_side = LEFT

func right():
	position =  Vector2(500,1070)
	_idle.flip_h = true
	_attacking.flip_h=true
	
	_dead.position = Vector2(28,41)
	_dead.flip_h=false
	_side = RIGHT

func attack():
	_animation.play("Attack")
