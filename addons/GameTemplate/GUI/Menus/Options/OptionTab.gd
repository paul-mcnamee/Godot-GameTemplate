extends Tabs

onready var translationName:String = self.name

func _ready() -> void:
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()
	pass # Replace with function body.

func retranslate() -> void:
	self.name = tr(translationName)
