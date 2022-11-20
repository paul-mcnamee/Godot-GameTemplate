extends Node2D

signal NewGame		#You choose how to use it
signal Continue		#You choose how to use it
signal Resume		#You choose how to use it
signal Restart		#Reloads current scene
signal ChangeScene	#Pass location of next scene file
signal Exit			#Triggers closing the game

onready var CurrentScene = null
var NextScene

var loader: = ResourceAsyncLoader.new()

onready var difficulty = 2 # Easy
onready var pacific_mode = false
onready var gore_enabled = true

func _ready()->void:
	connect("Exit",			self, "on_Exit")
	connect("ChangeScene",	self, "on_ChangeScene")
	connect("Restart", 		self, "restart_scene")
	#Silent Wolf configuration
	SilentWolf.configure({
				"api_key": Env.get("SILENTWOLF_API_KEY"),
				"game_id": Env.get("SILENTWOLF_GAME_ID"),
				"game_version": "1.0",
				"log_level": 0
				})
	SilentWolf.configure_auth({
				"redirect_to_scene": "res://MainMenu/MainMenu.tscn",
				"login_scene": "res://addons/silent_wolf/Auth/Login.tscn",
				"session_duration_seconds": 0,
				"saved_session_expiration_days": 30
				})

func on_ChangeScene(scene)->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	ScreenFade.state = ScreenFade.OUT
	if loader.can_async:
		NextScene = yield(loader.load_start( [scene] ), "completed")[0]				#Using ResourceAsyncLoader to load in next scene - it takes in array list and gives back array
	else:
		NextScene = loader.load_start( [scene] )[0]
	if NextScene == null:
		print_debug(' Game.gd - Loaded.resource is null')
		return
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	switch_scene()
	ScreenFade.state = ScreenFade.IN

func switch_scene()->void: 														#handles actual scene change
	CurrentScene = NextScene
	NextScene = null
	get_tree().change_scene_to(CurrentScene)

func restart_scene()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().reload_current_scene()


func on_Exit()->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	get_tree().quit()

