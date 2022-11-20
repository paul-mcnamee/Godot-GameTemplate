extends Node2D

var timer


func _ready():
	$CanvasLayer/CreateButton.connect("pressed", self, "create_timeout")
	$CanvasLayer/StartButton.connect("pressed", self, "start_timeout")
	$CanvasLayer/StopButton.connect("pressed", self, "stop_timeout")
	$CanvasLayer/DeleteButton.connect("pressed", self, "delete_timeout")


func create_timeout():
	timer = GlobalTimer.create_timeout(self, "print_text", 
		$CanvasLayer/WhiteBack/TimeInput.value, 
		$CanvasLayer/WhiteBack/AutoStartInput.pressed, 
		$CanvasLayer/WhiteBack/OneshotInput.pressed)


func start_timeout():
	GlobalTimer.start_timeout(timer)


func stop_timeout():
	GlobalTimer.stop_timeout(timer)


func delete_timeout():
	GlobalTimer.delete_timeout(timer)


func print_text():
	print($CanvasLayer/WhiteBack/TextInput.text)
