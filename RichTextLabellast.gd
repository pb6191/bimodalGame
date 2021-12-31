extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".text = "Please note down your code - " + global.participCode + ". You will need it for reimbursement. Your total winnings are: " + str(global.win) + "."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
