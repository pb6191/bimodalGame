extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.back2backDesign == 1:
		$"../RichTextLabel".visible = false
		$"../RichTextLabel2".visible = false
		$"../RichTextLabel3".visible = false
		$"../RichTextLabel4".visible = false
		$"../RichTextLabel6".visible = false
		$"../RichTextLabel7".visible = false
		$"../RichTextLabel8".visible = false
		$"../LineEdit".visible = false
		$"../LineEdit2".visible = false
		$"../LineEdit3".visible = false
		$"../LineEdit4".visible = false
		$"../LineEdit5".visible = false
		$"../LineEdit6".visible = false
		$"../SpinBox".visible = false
	else:
		$"../RichTextLabel5".visible = false
		$"../LineEdit7".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	global.trials = $"../SpinBox".value
	global.distance = $"../LineEdit".text
	global.deviation = $"../LineEdit2".text
	global.probability = $"../LineEdit3".text
	global.catcher = $"../LineEdit4".text
	global.payoff = $"../LineEdit5".text
	global.sample = $"../LineEdit6".text
	global.disArr = global.distance.split(",")
	global.devArr = global.deviation.split(",")
	global.proArr = global.probability.split(",")
	global.catArr = global.catcher.split(",")
	global.payArr = global.payoff.split(",")
	global.samArr = global.sample.split(",")
	global.participCode = $"../LineEdit7".text
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
