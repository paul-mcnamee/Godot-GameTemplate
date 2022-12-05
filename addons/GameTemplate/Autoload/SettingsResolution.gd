extends Node

signal Resized

#SCREEN
var Fullscreen = false setget set_fullscreen
var Borderless = false setget set_borderless
var View:Viewport
var ViewRect2:Rect2
var GameResolution:Vector2
var WindowResolution:Vector2
var ScreenResolution:Vector2
var ScreenAspectRatio:float

var Resolutions:Dictionary = {
	"640x360":Vector2(640,360),
	"800x600":Vector2(800,600),
	"1024x768":Vector2(1024,768),
	"1280x720":Vector2(1280,720),
	"1280x800":Vector2(1280,800),
	"1280x1024":Vector2(1280,1024),
	"1360x768":Vector2(1360,768),
	"1366x768":Vector2(1366,768),
	"1440x900":Vector2(1440,900),
	"1536x864":Vector2(1536,864),
	"1600x900":Vector2(1600,900),
	"1680x1050":Vector2(1680,1050),
	"1920x1080":Vector2(1920,1080),
	"1920x1200":Vector2(1920,1200),
	"2048x1152":Vector2(2048,1152),
	"2048x1536":Vector2(2048,1536),
	"2560x1080":Vector2(2560,1080),
	"2560x1440":Vector2(2560,1440),
	"2560x1600":Vector2(2560,1600),
	"3440x1440":Vector2(3440,1440),
	"3840x2160":Vector2(3840,2160),
}

#RESOLUTION
func set_fullscreen(value:bool)->void:
	Fullscreen = value
	OS.window_fullscreen = value
	OS.center_window()

func set_borderless(value:bool)->void:
	Borderless = value
	OS.window_borderless  = value

func get_resolution()->void:
	View = get_viewport()
	ViewRect2 = View.get_visible_rect()
	GameResolution = ViewRect2.size

	WindowResolution = OS.window_size
	ScreenResolution = OS.get_screen_size(OS.current_screen)
	ScreenAspectRatio = ScreenResolution.x/ScreenResolution.y

func set_resolution(value:Vector2)->void:
	GameResolution = value
	OS.set_window_size(value)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, value)

#SAVING RESOLUTION
func get_resolution_data()->Dictionary:
	var resolution_data:Dictionary = {}
	resolution_data["Borderless"] = Borderless
	resolution_data["Resolution"] = GameResolution
	resolution_data["Fullscreen"] = Fullscreen

	return resolution_data

#LOADING RESOLUTION
func set_resolution_data(value:Dictionary)->void:
	if ("Borderless" in value):
		SettingsResolution.set_borderless(value.Borderless)
	if ("Resolution" in value):
		SettingsResolution.set_resolution(value.Resolution)
	if ("Fullscreen" in value):
		SettingsResolution.set_fullscreen(value.Fullscreen)
