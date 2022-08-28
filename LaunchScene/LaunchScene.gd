extends ColorRect

export (String, FILE, "*.tscn") var Next_Scene: String


func _ready():
	Game.emit_signal("ChangeScene", Next_Scene)
