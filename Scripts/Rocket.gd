extends Area2D

@onready var VisibleNotifier = $VisibleNotifier
@export var speed = 1500;

func _ready():
	VisibleNotifier.connect("screen_exited", _onScreenExited)
	self.connect("area_entered", _on_area_entered)
	

func _physics_process(delta):
	global_position.x += speed*delta
	
func _onScreenExited():
	queue_free()
	
func _on_area_entered(area):
	queue_free()
	area.kill()
