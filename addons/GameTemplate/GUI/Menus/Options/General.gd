extends VBoxContainer

# TODO: move to individual scripts

onready var _tabContainer:TabContainer = $TabContainer

func _ready()->void:
	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func _on_Back_pressed()->void:
	SettingsSaveLoad.save_settings()

func retranslate()->void:
	find_node("Back").text = tr("BACK")
