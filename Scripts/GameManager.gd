extends Node

var biting = false
var score = 0
var skillDash = false
var skillDJ = false
var skillFlap = false
var currentScene = "MainMenu"
var numDeaths = 0

var preloadedScenes := {
	"MainMenu" : preload("res://Scenes/Levels/MainMenu.tscn"),
	"Level0" : preload("res://Scenes/Levels/Level0-Rendleman.tscn"),
	"Level1" : preload("res://Scenes/Levels/Level1-Lovejoy.tscn"),
	"Level2" : preload("res://Scenes/Levels/Level2-MUC.tscn"),
	"Level3" : preload("res://Scenes/Levels/Level3-Peck.tscn"),
	"Level4a" : preload("res://Scenes/Levels/Level4-ScienceWest.tscn"),
	"Level4b" : preload("res://Scenes/Levels/Level4-ScienceEast.tscn"),
	"Level5" : preload("res://Scenes/Levels/Level5-Engineering.tscn"),
	"WinScreen" : preload("res://Scenes/Levels/WinScreen.tscn")
}

var SceneList := ["MainMenu", "Level0", "Level1", "Level2", "Level3", "Level4a", "Level4b", "Level5", "WinScreen"]

func loadScene(sceneName: String):
	var newScene = preloadedScenes[sceneName]
	
	if newScene == null:
		newScene = preloadedScenes["MainMenu"]
		
	get_tree().change_scene_to_packed(newScene)

func getNextScene(curSceneName: String) -> String:
	print ("Getting", curSceneName)
	var where := SceneList.find(curSceneName)
	print(where)
	if where == -1 or where == SceneList.size() - 1:
		currentScene = "MainMenu"
		return "MainMenu"
	print(SceneList[where+1])
	currentScene = SceneList[where+1]
	return SceneList[where+1]

func onLevelComplete(levelName: String):
	print(levelName)
	var nextLevel := getNextScene(levelName)
	loadScene(nextLevel)

func gooseDied():
	print("Goose died")
	numDeaths += 1
	loadScene(currentScene)
