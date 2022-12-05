extends VBoxContainer

onready var DifficultyOptions: OptionButton =$HBoxContainer/DifficultySelect

func _ready()->void:
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

#Localization
func retranslate()->void:
	find_node("DifficultyLabel").text = tr("DIFFICULTY")

	var index = 0
	DifficultyOptions.clear()
	for d in SettingsGame.Difficulty:
		var difficultyOptionValue = SettingsGame.Difficulty.get(d)
		var difficultyOptionText = tr(SettingsGame.Difficulty.keys()[SettingsGame.Difficulty[d]])
		DifficultyOptions.add_item(difficultyOptionText, difficultyOptionValue)
		if SettingsGame.Difficulty[d] == SettingsGame.CurrentDifficulty:
			DifficultyOptions.selected = index
		index += 1

func _on_DifficultySelect_item_selected(value):
	SettingsGame.CurrentDifficulty = value
