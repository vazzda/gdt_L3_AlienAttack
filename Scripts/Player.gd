extends CharacterBody2D

signal DamageTaken

var RocketScene = preload("res://Scenes/Rocket.tscn")
var EnemyScene = preload("res://Scenes/enemy_simple.tscn")
@onready var RocketContainer = $RocketContainer
@onready var RocketLaunchSound = $Sounds/RocketLaunchSound



@export var shipVelocityX = 900
@export var shipVelocityY = 650
var boundexBoxLeft = 40
var boundexBoxRigth = 1200
var boundexBoxTop = 60
var boundexBoxBottom = 660
var rocketSpawnXOffest = 55


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	movePlayer()
	checkBoundaries()

func movePlayer():
	velocity = Vector2(0,0)

	if Input.is_action_pressed("move_right"):
		velocity.x = shipVelocityX
	if Input.is_action_pressed("move_left"):
		velocity.x = -shipVelocityX 
	if Input.is_action_pressed("move_up"):
		velocity.y = -shipVelocityY
	if Input.is_action_pressed("move_down"):
		velocity.y = shipVelocityY
	move_and_slide()


func checkBoundaries():
	global_position = global_position.clamp(
		Vector2(boundexBoxLeft, boundexBoxTop),
		Vector2(boundexBoxRigth, boundexBoxBottom)
	)
	
func shoot():
	var RocketInst = RocketScene.instantiate()
	RocketContainer.add_child(RocketInst)
	RocketInst.global_position = global_position
	RocketInst.global_position.x += rocketSpawnXOffest
	RocketLaunchSound.play()
	
func takeDamage():
	emit_signal("DamageTaken")

func die():
	queue_free()
	
	

