extends Area2D

@onready var Notifier = $OnScreenNotifier

signal EnemeDestroyedByPlayer(enemy)

@export var speed = 550;
@export var coins = 50;
@export var yShiftList = [-750, -500, -250, 0, 250, 500, 750]

var yShift = yShiftList.pick_random()
var yShiftEnabled = false;

var level_multiplier = 1;


func _ready():
	self.connect("body_entered", _onPlayerEntered)
	Notifier.connect("screen_exited", _onScreenExited)
	_calibrateShiftDirection()
	


func _physics_process(delta):
	global_position.x += -speed*delta*level_multiplier
	
	if yShiftEnabled:
		global_position.y += yShift*delta
	
	
func kill():
	emit_signal("EnemeDestroyedByPlayer", self)
	die()
	
func die():
	queue_free()

func getScore():
	return coins*level_multiplier	

func setLevelMult(mult):
	level_multiplier = mult
	
func setRandomYShift(boole):
	yShiftEnabled = boole

func _onPlayerEntered(body):
	body.takeDamage();
	die()
	
func _onScreenExited():
	yShift = yShift * -1

func _calibrateShiftDirection():
	if global_position.y > 650 && yShift > 0:
		yShift * -1
		print(str(global_position.y) + "   " + str(yShift))
		
	if global_position.y < 100 && yShift < 0:
		yShift * -1
		print(str(global_position.y) + "   " + str(yShift))
	
