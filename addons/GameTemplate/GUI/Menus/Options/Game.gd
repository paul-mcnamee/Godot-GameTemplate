extends VBoxContainer

func _ready()->void:
	MenuEvent.connect("Game", self, "on_show_game")
	MenuEvent.Game = false

	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

#EVENT SIGNALS
func on_show_game(value:bool)->void:
	visible = value
	if visible:
		get_tree().get_nodes_in_group("Game")[0].grab_focus()

#Localization
func retranslate()->void:
	find_node("DifficultyLabel").text = tr("DIFFICULTY")

	var dif_select = find_node("DifficultySelect")
	dif_select.clear()
	dif_select.add_item(tr("HARD"))
	dif_select.add_item(tr("NORMAL"))
	dif_select.add_item(tr("EASY"))

func _on_DifficultySelect_item_selected(index):
	Game.difficulty = index
