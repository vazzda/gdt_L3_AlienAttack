extends Node2D

signal enemy_spawned(enemy_instance)
signal level_updated(level)
signal level_tic(count)

var EnemyScene = preload("res://Scenes/enemy_simple.tscn")
@onready var SpawnTimer = $Timer
@onready var LevelTimer = $TimerLevel
@onready var SpawnPoses = $SpawnPositions

@export var level = 1

func _ready():
	SpawnTimer.connect("timeout", _on_the_timer_timeout)
	LevelTimer.connect("timeout", onLevelTimeOut)


func _on_the_timer_timeout():
	spawnEnemy()
	
func spawnEnemy():
	var Poses = SpawnPoses.get_children()
	var randomPos = Poses.pick_random()
	
	var EnemyInst = EnemyScene.instantiate()
	EnemyInst.setLevelMult(level)
	EnemyInst.global_position = randomPos.global_position
	EnemyInst.setRandomYShift(true)
	emit_signal("enemy_spawned", EnemyInst)

func onLevelTimeOut():
	level += 1
	emit_signal("level_updated", level)
	
func getLevel(): 
	return level

func getLevelTimeLeft(): 
	return int(LevelTimer.time_left)
	
func getLevelTimeOut(): 
	return LevelTimer.wait_time
