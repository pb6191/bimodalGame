extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if global.back2backDesign == 1:
		global.disArr = ["0", "500"]
		#std dev is doubled if the distance between peaks is 0
		#separate logic if distance >= 600
		global.devArr = ["83"]
		global.proArr = ["50"]
		#global.catArr = ["832"]
		global.catArr = ["150"]
		global.payArr = ["100"]
		global.samArr = ["20"]
		global.trials = 3
	get_tree().change_scene("res://Main.tscn")
