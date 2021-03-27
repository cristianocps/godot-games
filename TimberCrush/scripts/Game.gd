extends Node2D

onready var _player = get_node("Player")
onready var _mainCamera = get_node("MainCamera")
onready var _destroyingBarrels = get_node("DestroyingBarrels")
onready var _barrelStack = get_node("BarrelStack")
onready var _timeBar = get_node("TimeBar")
onready var _scoreLabel = get_node("ScoreLayer/ScoreLabel")
onready var _tryAgain = get_node("TryAgain")


var _barrel = preload("res://scenes/BarrelScene.tscn")
var _enemyRight = preload("res://scenes/EnemyRight.tscn")
var _enemyLeft = preload("res://scenes/EnemyLeft.tscn")
var _gameState =  ALIVE
var _score = 0;
var lastBarrelIsEnemy
const ALIVE = 1
const DEAD = -1

func _ready():
	randomize()
	set_process_input(true)
	generate_startup_barrels()
	_timeBar.connect("lost",self,"lose")
	_tryAgain.connect("try_again",self,"restart")

func _input(event):
	var newEvent = _mainCamera.make_input_local(event)
	if newEvent is InputEventScreenTouch and newEvent.is_pressed() and _gameState == ALIVE:
		if event.position.x < 360:
			_player.left()
		else:
			_player.right()
		check_action()	

func check_action():
	if !check_player_will_die(): 
			_player.attack()
			_score +=1
			var firstBarrel = _barrelStack.get_children()[0]
			firstBarrel.destroy(_player._side)
			print("posicao do barril:"+str(firstBarrel.position.y))
			_barrelStack.remove_child(firstBarrel)
			_destroyingBarrels.add_child(firstBarrel)
			randomize_barrel(Vector2(360, 1090- 10*172))
			slide_barrels_down()
			_timeBar.add_time(0.020)
			_scoreLabel.text = str(_score)
				
	else:
		lose()	

func slide_barrels_down():
	for barrel in _barrelStack.get_children():
		barrel.position.y = barrel.position.y+172
	if check_player_will_die(): lose()	
					
func generate_barrel(type,position):
	var barrel;
	
	match type:
		0:
			barrel = _barrel.instance()
			lastBarrelIsEnemy=false
			
		1:
			barrel = _enemyLeft.instance()
			barrel.add_to_group("LEFT_BARRELS")
			lastBarrelIsEnemy=true
		2:
			barrel = _enemyRight.instance()	
			barrel.add_to_group("RIGHT_BARRELS")
			lastBarrelIsEnemy=true
	
	barrel.position = position;
	_barrelStack.add_child(barrel)
	
	
func randomize_barrel(pos):
	var number = rand_range(0,3)
	if lastBarrelIsEnemy: number = 0
	generate_barrel(int(number),pos)

func generate_startup_barrels()	:
	for i in range(0,3):
		generate_barrel(0,Vector2(360,1090-i*172))
	
	for i in range(3,10):
		randomize_barrel(Vector2(360,1090 -i*172))

func check_player_will_die():
	var side = _player._side
	var firstBarrel = _barrelStack.get_children()[0]
	if side == _player.LEFT and firstBarrel.is_in_group("LEFT_BARRELS")	or side == _player.RIGHT and firstBarrel.is_in_group("RIGHT_BARRELS"):
		return true
	else:
		return false
		
func lose():
	_player.die()
	_gameState = DEAD
	_timeBar.set_process(false)
	_tryAgain.start_animation()

func restart():
	get_tree().reload_current_scene()

