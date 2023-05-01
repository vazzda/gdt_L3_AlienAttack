extends Control

@onready var RetryButton = $Panel/RetryButton
@onready var QuitButton = $Panel/QuitButton
@onready var ScoreLabel = $Panel/Score
@onready var LevelLabel = $Panel/Level

func _ready():
	RetryButton.connect("button_up", onReadyButtonUp)
	QuitButton.connect("button_up", onQuitButtonUp)
	
func setScore(score):
	ScoreLabel.text = "SCORE: " + str(score)

func setLevel(level):
	LevelLabel.text = "LEVEL: " + str(level)
	
func onReadyButtonUp():
	get_tree().reload_current_scene()
	
func onQuitButtonUp():
	get_tree().quit()
