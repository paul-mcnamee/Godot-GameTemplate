extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String
export var Duration : int

var timer

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(Duration)
	timer.connect("timeout", self, "finish")
	timer.autostart = true
	add_child(timer)


func finish():
	timer.stop()
	remove_child(timer)
	timer.queue_free()
	Game.emit_signal("ChangeScene", Next_Scene)
