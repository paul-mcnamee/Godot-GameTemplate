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

func _ready()->void:
	connect("NewGame", self, "on_NewGame")
	connect("Continue", self, "on_Continue")
	connect("Resume", self, "on_Resume")
	connect("Exit", self, "on_Exit")
	connect("ChangeScene", self, "on_ChangeScene")
	connect("Restart", self, "restart_scene")

func on_ChangeScene(scene)->void:
	if ScreenFade.state != ScreenFade.IDLE:
		return
	ScreenFade.state = ScreenFade.OUT
	if loader.can_async:
		#Using ResourceAsyncLoader to load in next scene - it takes in array list and gives back array
		NextScene = yield(loader.load_start( [scene] ), "completed")[0]
	else:
		NextScene = loader.load_start( [scene] )[0]
	if NextScene == null:
		print_debug(' Game.gd - Loaded.resource is null')
		return
	if ScreenFade.state != ScreenFade.BLACK:
		yield(ScreenFade, "fade_complete")
	switch_scene()
	ScreenFade.state = ScreenFade.IN

func on_NewGame() -> void:
	pass

func on_Continue() -> void:
	pass

func on_Resume() -> void:
	pass

func switch_scene()->void:
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

