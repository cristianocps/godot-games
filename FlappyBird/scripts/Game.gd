extends Node2D



onready var _player =  get_node("Player")
onready var _backgroundAnimation =  get_node("BackgroundAnimation")
onready var _timeToReplay =  get_node("TimeToReplay")
onready var _scoreLabel = get_node("Score/Control/ScoreText")
onready var _hitSound = get_node("HitSound")
onready var _scoreSound=get_node("ScoreSound")

const  PLAYING = 1
const  LOSING=2

var score = 0
var state=1


func _ready():
	_hitSound.stream.set_loop(false)
	_scoreSound.stream.set_loop(false)


func kill():
	_player.apply_impulse(Vector2(0,0),Vector2(-1000,0))
	_backgroundAnimation.stop()
	state=LOSING
	score=0
	_timeToReplay.start()
	_hitSound.play()
	

func score_point():
	score+=1
	_scoreSound.play()
	_scoreLabel.text = str(score);
	
	
func _on_TimeToReplay_timeout():
	get_tree().reload_current_scene()
