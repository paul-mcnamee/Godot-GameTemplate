extends Node


#AUDIO
var VolumeMain:float = 0.0 setget set_volume_main
var VolumeMusic:float = 0.0 setget set_volume_music
var VolumeSFX:float = 0.0 setget set_volume_sfx
const VolumeRange:float = 24.0 + 80.0

func _ready()->void:
	pass

#AUDIO
func get_volumes()->void:
	var Main:float	= db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Main")))
	var Music:float 	= db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	var SFX:float 		= db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

	set_volume_main(Main)
	set_volume_music(Music)
	set_volume_sfx(SFX)

func set_volume_main(volume:float)->void:
	VolumeMain = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Main"), linear2db(VolumeMain))

func set_volume_music(volume:float)->void:
	VolumeMusic = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(VolumeMusic))

func set_volume_sfx(volume:float)->void:
	VolumeSFX = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(VolumeSFX))


#SAVING AUDIO
func get_audio_data()->Dictionary:
	var audio_data:Dictionary = {}
	audio_data["Main"] = SettingsAudio.VolumeMain
	audio_data["Music"] = SettingsAudio.VolumeMusic
	audio_data["SFX"] = SettingsAudio.VolumeSFX
	return audio_data

#LOADING AUDIO
func set_audio_data(audio:Dictionary)->void:
	SettingsAudio.set_volume_main(audio.Main)
	SettingsAudio.set_volume_music(audio.Music)
	SettingsAudio.set_volume_sfx(audio.SFX)





