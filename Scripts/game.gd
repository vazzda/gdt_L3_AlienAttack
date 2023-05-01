extends Node2D

@onready var PlayerNode = $Player
@onready var EnemySpawner = $EnemySpawner
@onready var UI = $UI
@onready var HUD = $UI/HUD
@onready var enemy_hit_sound = $Sounds/EnemyHitSound
@onready var player_hit_sound = $Sounds/PlayerHItSound

var gameOverScene = preload("res://Scenes/game_over_screen.tscn")


var livesLeft = 3
var globalScore = 0

func _ready():
	PlayerNode.connect("DamageTaken", onPlayerTakeDamage)
	EnemySpawner.connect("enemy_spawned", onEnemySpawned)
	EnemySpawner.connect("level_updated", onLevelUpdated)
	
	clearHUD()
	
func clearHUD():
	HUD.setScore(0)
	HUD.setLifes(livesLeft)
	HUD.setLevel(EnemySpawner.getLevel())
	HUD.setLevelRemain(EnemySpawner.getLevelTimeOut())

func onPlayerTakeDamage():
	player_hit_sound.play()
	livesLeft -= 1
	if livesLeft >= 0:
		updateLifes()
	elif livesLeft < 0:
		setGameOver()
		
func onEnemySpawned(Enemy):
	Enemy.connect("EnemeDestroyedByPlayer", onEnemyDestroyed)
	add_child(Enemy)
	HUD.setLevelRemain(EnemySpawner.getLevelTimeLeft())
	
func onEnemyDestroyed(enemy):
	enemy_hit_sound.play()
	globalScore += enemy.getScore()
	HUD.setScore(globalScore)
	
func updateLifes():
	HUD.setLifes(livesLeft)

func updateLevel():
	HUD.setLevel(EnemySpawner.getLevel())

func setGameOver():
	PlayerNode.die()
	
	await get_tree().create_timer(0.5).timeout
	var GOInst = gameOverScene.instantiate()
	GOInst.visible = false
	UI.add_child(GOInst)
	GOInst.setScore(globalScore)
	GOInst.setLevel(EnemySpawner.getLevel())
	GOInst.visible = true

func onLevelUpdated(level):
	HUD.setLevel(EnemySpawner.getLevel())
	HUD.setLevelRemain(EnemySpawner.getLevelTimeOut())
