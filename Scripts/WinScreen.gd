extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Score.text = "Score: " + str(GameManager.score)
	$Control/Deaths.text = "Deaths: " + str(GameManager.numDeaths)


func _on_button_pressed():
	GameManager.loadScene("MainMenu")
