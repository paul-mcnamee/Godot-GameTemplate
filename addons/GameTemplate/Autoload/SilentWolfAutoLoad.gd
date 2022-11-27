extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
