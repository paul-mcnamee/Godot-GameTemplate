extends VBoxContainer

onready var ResolutionOptionsButton: OptionButton = $HBoxContainer/VBoxContainer/Resolution

func _ready() -> void:
	# set up toggles and sliders
	if Settings.HTML5:
		find_node("Borderless").visible = false
		find_node("Scale").visible = false
	var CurrentResolution = get_viewport().get_size()
	var index = 0
	for r in SettingsResolution.Resolutions:
		ResolutionOptionsButton.add_item(r)
		if SettingsResolution.Resolutions[r] == CurrentResolution:
			ResolutionOptionsButton.selected = index
		index += 1
	set_resolution()

	SettingsResolution.connect("Resized", self, "_on_Resized")
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func set_resolution()->void:
	find_node("Fullscreen").pressed = SettingsResolution.Fullscreen
	find_node("Borderless").pressed = SettingsResolution.Borderless

func _on_Fullscreen_pressed()->void:
	SettingsResolution.Fullscreen = find_node("Fullscreen").pressed

func _on_Borderless_pressed()->void:
	SettingsResolution.Borderless = find_node("Borderless").pressed

func _on_Resized()->void:
	set_resolution()

func retranslate()->void:
	find_node("Resolution").text 	= tr("RESOLUTION")
	find_node("Fullscreen").text 	= tr("FULLSCREEN")
	find_node("Borderless").text 	= tr("BORDERLESS")

func _on_Resolution_item_selected(index: int) -> void:
	var resolution = SettingsResolution.Resolutions[ResolutionOptionsButton.get_item_text(index)]
	SettingsResolution.set_resolution(resolution)
