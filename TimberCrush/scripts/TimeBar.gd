extends Node2D


onready var _timeMark = get_node("TimeMark")
signal lost()

var percentage = 1;

func _ready():
	set_process(true)

func _process(delta):
	if percentage > 0:
		percentage-=0.1*delta
		_timeMark.region_rect = Rect2(0,0,percentage*188,23)
		_timeMark.position = Vector2(-(1-percentage)*188/2,0)
	else:
		emit_signal("lost")	
				
func add_time(delta):
	percentage+=delta
	if percentage>1 : percentage=1		
