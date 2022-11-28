extends Tabs

onready var translationName:String = self.name

func _ready() -> void:
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()

func retranslate() -> void:
	self.name = tr(translationName)
