extends VBoxContainer

# TODO: move to individual scripts

onready var _tabContainer:TabContainer = $TabContainer

func _ready()->void:
	#Set up toggles and sliders
	if Settings.HTML5:
		find_node("Borderless").visible = false
		find_node("Scale").visible = false
	set_resolution()

	MenuEvent.connect("Controls", self, "on_show_controls")
	MenuEvent.connect("Languages", self, "on_show_languages")
	MenuEvent.connect("Game", self, "on_show_game")
	SettingsResolution.connect("Resized", self, "_on_Resized")
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func set_resolution()->void:
	find_node("Fullscreen").pressed = SettingsResolution.Fullscreen
	find_node("Borderless").pressed = SettingsResolution.Borderless
	#Your logic for scaling

func _on_Fullscreen_pressed()->void:
	SettingsResolution.Fullscreen = find_node("Fullscreen").pressed

func _on_Borderless_pressed()->void:
	SettingsResolution.Borderless = find_node("Borderless").pressed

func _on_ScaleUp_pressed()->void:
	SettingsResolution.Scale += 1

func _on_ScaleDown_pressed()->void:
	SettingsResolution.Scale -= 1

func _on_Resized()->void:
	set_resolution()

func _on_Controls_pressed()->void:
	MenuEvent.Controls = true

func _on_Back_pressed()->void:
	SettingsSaveLoad.save_settings()
	MenuEvent.Options = false
	if PauseMenu.can_show:
		get_tree().get_nodes_in_group("Pause")[0].grab_focus()

func _on_Languages_pressed()->void:
	MenuEvent.Languages = true

#EVENT SIGNALS
func on_show_controls(value:bool)->void:
	visible = !value 	#because showing controls
	if visible:
		get_tree().get_nodes_in_group("General")[0].grab_focus()

#Localization - TODO: this seems really prone to failure
func retranslate()->void:
	find_node("Resolution").text 	= tr("RESOLUTION")
	find_node("Fullscreen").text 	= tr("FULLSCREEN")
	find_node("Borderless").text 	= tr("BORDERLESS")
	find_node("Scale").text 		= tr("SCALE")
	find_node("Back").text 			= tr("BACK")

func set_node_in_focus()->void:
	var FocusGroup:Array = get_groups()

func _on_Game_pressed():
	MenuEvent.set_game(true)

func on_show_game(value:bool)->void:
	visible = !value
	if visible:
		get_tree().get_nodes_in_group("General")[0].grab_focus()
