extends Control

@onready var ScoreLable = $Score
@onready var LifesLable = $Lifes
@onready var LevelLable = $Level
@onready var LevelRemainLable = $LevelRemain

var SCORE_TEXT = "SCORE: "
var LEVEL_TEXT = "LEVEL: "
var TIME_REMAINED_TEXT = "TIME REMAINED: "


func setScore(newScore):
	ScoreLable.text = SCORE_TEXT + str(newScore)
	
func setLifes(lifesLeft):
	LifesLable.text = str(lifesLeft)

func setLevel(level):
	LevelLable.text = LEVEL_TEXT + str(level)

func setLevelRemain(remain):
	LevelRemainLable.text = TIME_REMAINED_TEXT + str(remain)
