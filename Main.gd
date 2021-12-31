extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var disArr1
var devArr1
var proArr1
var catArr1
var payArr1
var samArr1
var FULLdisArr1 = []
var FULLdevArr1 = []
var FULLproArr1 = []
var FULLcatArr1 = []
var FULLpayArr1 = []
var FULLsamArr1 = []
var FULLindexArr1 = []
var trials1
var totalTrials
var trialNum = -1
var rng6 = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var rng3 = RandomNumberGenerator.new()
var rng = RandomNumberGenerator.new()
var tempOdd
var tempIndex
var tempX

var txt1 = "Start Trial"
var txt2 = "Adjust Catcher"
var txt3 = "See Result"
var freshPress = false

var traceFolder
var traceFolderName
var characters = 'abcdefghijklmnopqrstuvwxyz'
var temp
var temp2

# Called when the node enters the scene tree for the first time.
func _ready():
	global.playItertn += 1
	if (global.back2backDesign == 1):
		if global.playItertn == 1:
			global.win = 0
	else:
		global.win = 0
	traceFolderName = generate_word(characters, 10)
	disArr1 = global.disArr
	devArr1 = global.devArr
	proArr1 = global.proArr
	catArr1 = global.catArr
	payArr1 = global.payArr
	samArr1 = global.samArr
	trials1 = global.trials
	totalTrials = len(disArr1)*len(devArr1)*len(proArr1)*len(catArr1)*len(payArr1)*len(samArr1)*trials1
	for i1 in int(trials1):
		for i2 in len(disArr1):
			for i3 in len(devArr1):
				for i4 in len(proArr1):
					for i5 in len(catArr1):
						for i6 in len(payArr1):
							for i7 in len(samArr1):
								FULLdisArr1.push_back(float(disArr1[i2]))
								FULLdevArr1.push_back(float(devArr1[i3]))
								FULLproArr1.push_back(float(proArr1[i4]))
								FULLcatArr1.push_back(float(catArr1[i5]))
								FULLpayArr1.push_back(float(payArr1[i6]))
								FULLsamArr1.push_back(float(samArr1[i7]))
	for i8 in int(totalTrials):
		FULLindexArr1.push_back(i8)
	for k in int(totalTrials):
		rng6.randomize()
		tempIndex = rng6.randi_range(0, (int(totalTrials)-1))
		tempOdd = FULLindexArr1[k]
		FULLindexArr1[k] = FULLindexArr1[tempIndex]
		FULLindexArr1[tempIndex] = tempOdd
	$"Button".text = txt1




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"Button".text == txt3:
		if Input.is_action_pressed("ui_right"):
			$"Sprite2".position.x +=1
			$"Sprite3".position.x +=1
		if Input.is_action_pressed("ui_left"):
			$"Sprite2".position.x -=1
			$"Sprite3".position.x -=1

func getX():
	rng2.randomize()
	rng3.randomize()
	if rng3.randi_range(1, 100) <= FULLproArr1[FULLindexArr1[trialNum]]:
		if (global.back2backDesign == 1 and int(FULLdisArr1[FULLindexArr1[trialNum]]) == 0):
			tempX = 500 + int(rng2.randfn(0.0, (2*FULLdevArr1[FULLindexArr1[trialNum]]))) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
		else:
			tempX = 500 + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
	else:
		if (global.back2backDesign == 1 and int(FULLdisArr1[FULLindexArr1[trialNum]]) == 0):
			tempX = 500 + int(rng2.randfn(0.0, (2*FULLdevArr1[FULLindexArr1[trialNum]]))) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
		else:
			tempX = 500 + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
	return tempX


func spawnCookies():
	print(str(FULLsamArr1[FULLindexArr1[trialNum]]))
	var howmany = 0
	for j in FULLsamArr1[FULLindexArr1[trialNum]]: 
		if has_node("Spritedot"):
			temp = $"Spritedot".duplicate()
			temp.set_name(generate_word(characters, 10))
			temp.position.x = getX()
			get_node("Node/"+traceFolderName).add_child(temp)
			howmany += 1
			print(str(howmany)+" - "+str(temp.position.x))

func spawnOne():
	if has_node("Spritedot"):
		temp2 = $"Spritedot".duplicate()
		temp2.set_name(generate_word(characters, 10))
		temp2.position.x = getX()
		if (temp2.position.x <= $"Sprite3".position.x and temp2.position.x >= $"Sprite2".position.x):
			global.win += FULLpayArr1[FULLindexArr1[trialNum]]
			$"AudioStreamPlayerW".play()
			temp2.modulate = Color( 0, 1, 0, 1 )
		else:
			$"AudioStreamPlayerL".play()
			temp2.modulate = Color( 1, 0, 0, 1 )
		$"RichTextLabel2".text = "Total Winnings: "+str(global.win)
		get_node("Node/"+traceFolderName).add_child(temp2)

func _on_Button_pressed():
	if $"Button".text == txt1 and freshPress == true:
		freshPress = false
		trialNum +=1
		$"RichTextLabel".text = "Trial Number "+str(trialNum+1)+" of "+str(totalTrials)
		$"RichTextLabel3".text = "Payoff for this trial: "+str(FULLpayArr1[FULLindexArr1[trialNum]])
		$"Sprite2".visible = false
		$"Sprite3".visible = false
		for i2 in $"Node".get_children():
			i2.free()
		if has_node("Node/"+traceFolderName):
			get_node("Node/"+traceFolderName).free()
		if has_node("Node"):
			traceFolder = $"Node2".duplicate()
			traceFolder.set_name(traceFolderName)
			$"Node".add_child(traceFolder)
		spawnCookies()
		$"AudioStreamPlayerS".play()
		$"Button".text = txt2
	if $"Button".text == txt2 and freshPress == true:
		freshPress = false
		var randPosnCatcher = (randi() % 1000) + 1
		$"Sprite2".position.x = randPosnCatcher - int(FULLcatArr1[FULLindexArr1[trialNum]]/2)
		$"Sprite3".position.x = randPosnCatcher + int(FULLcatArr1[FULLindexArr1[trialNum]]/2)
		$"Sprite2".visible = true
		$"Sprite3".visible = true
		$"Button".text = txt3
	if $"Button".text == txt3 and freshPress == true:
		freshPress = false
		spawnOne()
		if (trialNum+1)==totalTrials:
			$"Button".text = "Main Screen"
		else:
			$"Button".text = txt1
	if $"Button".text == "Main Screen" and freshPress == true:
		freshPress = false
		if (global.back2backDesign == 1):
			if global.playItertn == 1:
				get_tree().change_scene("res://Intermid.tscn")
			else:
				get_tree().change_scene("res://Closing.tscn")
		else:
			get_tree().change_scene("res://Menu.tscn")


func _on_Button_button_down():
	freshPress = true

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		rng.randomize()
		word += chars[rng.randi_range(0, (n_char-1))]
	return word
