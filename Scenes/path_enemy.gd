extends Path2D

@onready var pathFollow = $PathFollow2D
@onready var enemy = $PathFollow2D/EnemySimple

func _ready():
	pathFollow.set_progress_ratio(1)
	
func _process(delta):
	pathFollow.progress_ratio -= 0.15*delta
	if pathFollow.progress_ratio <= 0:
		queue_free()
