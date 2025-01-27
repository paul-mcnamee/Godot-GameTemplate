extends VBoxContainer

signal Language_choosen

onready var button:PackedScene = preload("res://addons/GameTemplate/GUI/Buttons/DefaultButton.tscn")
onready var button_parent:HBoxContainer = $LanguageContainer

func _ready()->void:
	MenuEvent.connect("Languages", self, "on_show_languages")
#	MenuEvent.Languages = false #just in case project saved with visible Languages

	for language in SettingsLanguage.Language_list:			#For each language generate button
		var newButton:Button = button.instance()
		button_parent.add_child(newButton)
		newButton.text = "\"" + language + "\""
		newButton.connect("pressed", self, "_on_language_pressed", [language])

	#Localization
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func _on_language_pressed(value:String)->void:
	SettingsLanguage.Language = SettingsLanguage.Language_dictionary[value] #Settings will emit ReTranslate signal
	MenuEvent.Languages = false

#EVENT SIGNALS
func on_show_languages(value:bool)->void:
	$LanguageContainer.get_child(0).grab_focus()
	pass

#Localization
func retranslate()->void:
	pass
