extends Node

enum Difficulty {
	EASY,
	NORMAL,
	HARD,
	INSANE,
}

var CurrentDifficulty = Difficulty.EASY setget set_current_difficulty

func set_current_difficulty(value)->void:
	CurrentDifficulty = value

#SAVING GAME SETTINGS
func get_game_data()->Dictionary:
	var game_data:Dictionary = {}
	game_data["CurrentDifficulty"] = CurrentDifficulty
	return game_data

#LOADING GAME SETTINGS
func set_game_data(value:Dictionary)->void:
	if ("CurrentDifficulty" in value):
		SettingsGame.set_current_difficulty(value.CurrentDifficulty)
