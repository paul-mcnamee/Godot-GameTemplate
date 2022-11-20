extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String
export var Duration_Seconds : float

var timer

func _ready():
	timer = GlobalTimer.create_timeout(self, "finish", Duration_Seconds, true, true)


func finish():
	GlobalTimer.delete_timeout(timer)
	Game.emit_signal("ChangeScene", Next_Scene)
