extends Area2D

func _ready():
	self.connect("area_entered", onAreaEntered)
	
func onAreaEntered(area):
	area.die()

