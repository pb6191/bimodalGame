extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".text = "Please note down your code - " + global.participCode + ". You will need it for reimbursement. You will be paid for trial #50 in session(s) and your total is as follows:"
	$"../ItemList".add_item(" ", null, false)
	$"../ItemList".add_item("Points Caught", null, false)
	$"../ItemList".add_item("Dollar Equivalent", null, false)
	$"../ItemList".add_item("Session 1 Catcher 1", null, false)
	$"../ItemList".add_item(global.sess1var1, null, false)
	$"../ItemList".add_item(global.sess1var2, null, false)
	$"../ItemList".add_item("Session 1 Catcher 2", null, false)
	$"../ItemList".add_item(global.sess1var3, null, false)
	$"../ItemList".add_item(global.sess1var4, null, false)
	$"../ItemList".add_item("Session 1 Total", null, false)
	$"../ItemList".add_item(global.sess1var5, null, false)
	$"../ItemList".add_item(global.sess1var6, null, false)
	
	$"../ItemList".add_item("Session 2 Catcher 1", null, false)
	$"../ItemList".add_item(global.sess2var1, null, false)
	$"../ItemList".add_item(global.sess2var2, null, false)
	$"../ItemList".add_item("Session 2 Catcher 2", null, false)
	$"../ItemList".add_item(global.sess2var3, null, false)
	$"../ItemList".add_item(global.sess2var4, null, false)
	$"../ItemList".add_item("Session 2 Total", null, false)
	$"../ItemList".add_item(global.sess2var5, null, false)
	$"../ItemList".add_item(global.sess2var6, null, false)
	$"../ItemList".add_item("Grand TOTAL", null, false)
	$"../ItemList".add_item(str(float(global.sess1var5) + float(global.sess2var5)), null, false)
	$"../ItemList".add_item(str(float(global.sess1var6) + float(global.sess2var6)), null, false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
