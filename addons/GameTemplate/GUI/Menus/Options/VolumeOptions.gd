extends VBoxContainer

onready var Main_player:AudioStreamPlayer = $Main
onready var Music_player:AudioStreamPlayer = $Music
onready var SFX_player:AudioStreamPlayer = $SFX

onready var Main_slider:HSlider = $Main/HSlider
onready var Music_slider:HSlider = $Music/HSlider
onready var SFX_slider:HSlider = $SFX/HSlider

onready var Main_AudioStreamPlayer:AudioStreamPlayer = $Main/AudioStreamPlayer
onready var Music_AudioStreamPlayer:AudioStreamPlayer = $Music/AudioStreamPlayer
onready var SFX_AudioStreamPlayer:AudioStreamPlayer = $SFX/AudioStreamPlayer

var beep: = preload("res://addons/GameTemplate/Assets/Sounds/TestBeep.wav")

func _ready() -> void:
	SettingsLanguage.connect("ReTranslate", self, "retranslate")
	retranslate()
	set_volume_sliders()

func retranslate() -> void:
	$Main/ScaleName.text	= tr("MAIN")
	$Music/ScaleName.text 	= tr("MUSIC")
	$SFX/ScaleName.text 	= tr("SFX")

func set_volume_sliders()->void: #Initialize volume sliders
	Main_slider.value = SettingsAudio.VolumeMain * 100
	Music_slider.value = SettingsAudio.VolumeMusic * 100
	SFX_slider.value = SettingsAudio.VolumeSFX * 100
	Main_player.stream = beep
	Music_player.stream = beep
	SFX_player.stream = beep

#### BUTTON SIGNALS ####
func _on_Main_value_changed(value)->void:
	SettingsAudio.VolumeMain = value/100
	Main_AudioStreamPlayer.play()

func _on_Music_value_changed(value)->void:
	SettingsAudio.VolumeMusic = value/100
	Music_AudioStreamPlayer.play()

func _on_SFX_value_changed(value)->void:
	SettingsAudio.VolumeSFX = value/100
	SFX_AudioStreamPlayer.play()
