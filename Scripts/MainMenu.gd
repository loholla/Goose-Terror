extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	GameManager.score = 0
	GameManager.numDeaths = 0


func _on_button_pressed():
	GameManager.onLevelComplete(GameManager.currentScene)
