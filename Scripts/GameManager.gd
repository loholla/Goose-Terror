extends Node

var preloadedScenes := {
	"MainMenu" : preload("res://Scenes/Levels/MainMenu.tscn"),
	"Level0" : preload("res://Scenes/Levels/Level0-Rendleman.tscn"),
	"Level1" : preload("res://Scenes/Levels/Level1-Lovejoy.tscn"),
	"Level2" : preload("res://Scenes/Levels/Level2-MUC.tscn"),
	"Level3" : preload("res://Scenes/Levels/Level3-Peck.tscn"),
	"Level4" : preload("res://Scenes/Levels/Level4-Sciences.tscn"),
	"Level5" : preload("res://Scenes/Levels/Level5-Engineering.tscn")
}

var SceneList := ["MainMenu", "Level0", "Level1", "Level2", "Level3", "Level4", "Level5"]
