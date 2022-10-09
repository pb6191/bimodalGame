extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonIntermed_pressed():
	global.disArr = ["500", "0", "250", "200", "300", "400"]
	#std dev is doubled if the distance between peaks is 0
	#separate logic if distance >= 600
	global.devArr = ["83", "28", "56"]
	global.proArr = ["50"]
	#global.catArr = ["332", "832"]
	global.catArr = ["150"]
	global.payArr = ["100"]
	global.samArr = ["20"]
	global.trials = [5, 25, 5, 5, 5, 5]
	get_tree().change_scene("res://Main.tscn")
