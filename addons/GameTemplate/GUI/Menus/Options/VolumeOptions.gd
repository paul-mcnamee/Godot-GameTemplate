extends VBoxContainer

onready var Main_slider:HSlider = $VolumeSliders/Main/HSlider
onready var Music_slider:HSlider = $VolumeSliders/Music/HSlider
onready var SFX_slider:HSlider = $VolumeSliders/SFX/HSlider

onready var Main_AudioStreamPlayer:AudioStreamPlayer = $VolumeSliders/Main/AudioStreamPlayer
onready var Music_AudioStreamPlayer:AudioStreamPlayer = $VolumeSliders/Music/AudioStreamPlayer
onready var SFX_AudioStreamPlayer:AudioStreamPlayer = $VolumeSliders/SFX/AudioStreamPlayer

var beep: = preload("res://addons/GameTemplate/Assets/Sounds/TestBeep.wav")

func _ready() -> void:
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	Main_slider.connect("value_changed", self, "_on_Main_value_changed")
	Music_slider.connect("value_changed", self, "_on_Music_value_changed")
	SFX_slider.connect("value_changed", self, "_on_SFX_value_changed")
	retranslate()
	initialize_volume_sliders()

func retranslate() -> void:
	$VolumeSliders/Main/ScaleName.text	= tr("MAIN")
	$VolumeSliders/Music/ScaleName.text = tr("MUSIC")
	$VolumeSliders/SFX/ScaleName.text 	= tr("SFX")

#Initialize volume sliders
func initialize_volume_sliders()->void:
	Main_slider.value = SettingsAudio.VolumeMain * 100
	Music_slider.value = SettingsAudio.VolumeMusic * 100
	SFX_slider.value = SettingsAudio.VolumeSFX * 100
	Main_AudioStreamPlayer.stream = beep
	Music_AudioStreamPlayer.stream = beep
	SFX_AudioStreamPlayer.stream = beep

#### BUTTON SIGNALS ####
func _on_Main_value_changed(value:float)->void:
	SettingsAudio.VolumeMain = value/100
	Main_AudioStreamPlayer.play()

func _on_Music_value_changed(value:float)->void:
	SettingsAudio.VolumeMusic = value/100
	Music_AudioStreamPlayer.play()

func _on_SFX_value_changed(value:float)->void:
	SettingsAudio.VolumeSFX = value/100
	SFX_AudioStreamPlayer.play()
