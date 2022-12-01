extends VBoxContainer

# TODO: move to individual scripts

onready var _tabContainer:TabContainer = $TabContainer

func _ready()->void:
	MenuEvent.connect("Controls", self, "on_show_controls")
	MenuEvent.connect("Languages", self, "on_show_languages")
	MenuEvent.connect("Game", self, "on_show_game")

	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func _on_Back_pressed()->void:
	SettingsSaveLoad.save_settings()
	MenuEvent.Options = false
	if PauseMenu.can_show:
		get_tree().get_nodes_in_group("Pause")[0].grab_focus()

#EVENT SIGNALS
func on_show_controls(value:bool)->void:
	visible = !value 	#because showing controls
	if visible:
		get_tree().get_nodes_in_group("General")[0].grab_focus()

func retranslate()->void:
	find_node("Back").text = tr("BACK")

func set_node_in_focus()->void:
	var FocusGroup:Array = get_groups()

func on_show_game(value:bool)->void:
	visible = !value
	if visible:
		get_tree().get_nodes_in_group("General")[0].grab_focus()




# TODO: these can probably be deleted
func _on_Languages_pressed()->void:
	MenuEvent.Languages = true

func _on_Game_pressed():
	MenuEvent.set_game(true)

func _on_Controls_pressed()->void:
	MenuEvent.Controls = true
