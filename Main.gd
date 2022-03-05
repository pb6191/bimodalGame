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
var rng4 = RandomNumberGenerator.new()
var rng5 = RandomNumberGenerator.new()
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
var catchFolder
var catchFolderName
var characters = 'abcdefghijklmnopqrstuvwxyz'
var temp
var temp2
var temp3
var temp4
var catchersp2
var catchersp3

var readyclick = 0
var catcheroutside = 0
var offset
var numcatchers
var greenlist

# Called when the node enters the scene tree for the first time.
func _ready():
	global.playItertn += 1
	if (global.back2backDesign == 1):
		if global.playItertn == 1:
			global.win = 0
	else:
		global.win = 0
	traceFolderName = generate_word(characters, 10)
	catchFolderName = generate_word(characters, 10)
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
		rng6.seed
		tempIndex = rng6.randi_range(0, (int(totalTrials)-1))
		print("tempinde"+str(tempIndex))
		tempOdd = FULLindexArr1[k]
		FULLindexArr1[k] = FULLindexArr1[tempIndex]
		FULLindexArr1[tempIndex] = tempOdd
	$"Button".text = txt1




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"Button".text == txt3:
		#if Input.is_action_pressed("ui_right"):
		#	$"Sprite2".position.x +=1
		#	$"Sprite3".position.x +=1
		#if Input.is_action_pressed("ui_left"):
		#	$"Sprite2".position.x -=1
		#	$"Sprite3".position.x -=1
		if InputEventMouseMotion:
			if catcheroutside == 0:
				$"Sprite2".position.x = get_global_mouse_position().x - int(FULLcatArr1[FULLindexArr1[trialNum]]/2)
				$"Sprite3".position.x = get_global_mouse_position().x + int(FULLcatArr1[FULLindexArr1[trialNum]]/2)
			else:
				$"Sprite2".position.x = -20
				$"Sprite3".position.x = -20
		if Input.is_action_just_pressed("lmb"):
			readyclick = 1
		if Input.is_action_just_released("lmb") and readyclick == 1:
			readyclick = 0
			spawnOneCatcher()

func getX():
	rng2.randomize()
	rng3.randomize()
	rng4.randomize()
	# currently getting the seeds, can later set the seeds to reproduce same point patterns
	rng2.seed
	rng3.seed
	rng4.seed
	if FULLdisArr1[FULLindexArr1[trialNum]] < 600:
		if rng3.randi_range(1, 100) <= FULLproArr1[FULLindexArr1[trialNum]]:
			if (global.back2backDesign == 1 and int(FULLdisArr1[FULLindexArr1[trialNum]]) == 0):
				tempX = offset + int(rng2.randfn(0.0, (2*FULLdevArr1[FULLindexArr1[trialNum]]))) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			else:
				tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
		else:
			if (global.back2backDesign == 1 and int(FULLdisArr1[FULLindexArr1[trialNum]]) == 0):
				tempX = offset + int(rng2.randfn(0.0, (2*FULLdevArr1[FULLindexArr1[trialNum]]))) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			else:
				tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
	else:
		if rng4.randi_range(1, 99) <= 33:
			if (global.back2backDesign == 1):
				tempX = offset + int(rng2.randfn(0.0, (0.6666*FULLdevArr1[FULLindexArr1[trialNum]])))
			else:
				tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]]))
		else:
			if rng3.randi_range(1, 100) <= FULLproArr1[FULLindexArr1[trialNum]]:
				if (global.back2backDesign == 1):
					tempX = offset + int(rng2.randfn(0.0, (0.6666*FULLdevArr1[FULLindexArr1[trialNum]]))) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
				else:
					tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			else:
				if (global.back2backDesign == 1):
					tempX = offset + int(rng2.randfn(0.0, (0.6666*FULLdevArr1[FULLindexArr1[trialNum]]))) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
				else:
					tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
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

func spawnModes():
	if FULLdisArr1[FULLindexArr1[trialNum]] >= 600:
		if has_node("Spritedot"):
			temp2 = $"Spritedot".duplicate()
			temp2.set_name(generate_word(characters, 10))
			temp2.position.x = offset
			temp3 = $"Spritedot".duplicate()
			temp3.set_name(generate_word(characters, 10))
			temp3.position.x = offset - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			temp4 = $"Spritedot".duplicate()
			temp4.set_name(generate_word(characters, 10))
			temp4.position.x = offset + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			if (numcatchers == 3 and temp2.position.x in greenlist and temp3.position.x in greenlist and temp4.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				$"AudioStreamPlayerW".play()
				temp2.modulate = Color( 0, 1, 0, 1 )
				temp3.modulate = Color( 0, 1, 0, 1 )
				temp4.modulate = Color( 0, 1, 0, 1 )
			else:
				$"AudioStreamPlayerL".play()
				temp2.modulate = Color( 1, 0, 0, 1 )
				temp3.modulate = Color( 1, 0, 0, 1 )
				temp4.modulate = Color( 1, 0, 0, 1 )
			$"RichTextLabel2".text = "Total Winnings: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp2)
			get_node("Node/"+traceFolderName).add_child(temp3)
			get_node("Node/"+traceFolderName).add_child(temp4)
	elif FULLdisArr1[FULLindexArr1[trialNum]] == 0:
		if has_node("Spritedot"):
			temp2 = $"Spritedot".duplicate()
			temp2.set_name(generate_word(characters, 10))
			temp2.position.x = offset
			if (numcatchers == 1 and temp2.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				$"AudioStreamPlayerW".play()
				temp2.modulate = Color( 0, 1, 0, 1 )
			else:
				$"AudioStreamPlayerL".play()
				temp2.modulate = Color( 1, 0, 0, 1 )
			$"RichTextLabel2".text = "Total Winnings: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp2)
	else:
		if has_node("Spritedot"):
			temp3 = $"Spritedot".duplicate()
			temp3.set_name(generate_word(characters, 10))
			temp3.position.x = offset - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			temp4 = $"Spritedot".duplicate()
			temp4.set_name(generate_word(characters, 10))
			temp4.position.x = offset + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			if (numcatchers == 2 and temp3.position.x in greenlist and temp4.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				$"AudioStreamPlayerW".play()
				temp3.modulate = Color( 0, 1, 0, 1 )
				temp4.modulate = Color( 0, 1, 0, 1 )
			else:
				$"AudioStreamPlayerL".play()
				temp3.modulate = Color( 1, 0, 0, 1 )
				temp4.modulate = Color( 1, 0, 0, 1 )
			$"RichTextLabel2".text = "Total Winnings: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp3)
			get_node("Node/"+traceFolderName).add_child(temp4)

func spawnOneCatcher():
	print("catcher placed")
	numcatchers += 1
	for n1 in range($"Sprite2".position.x, $"Sprite3".position.x):
		greenlist.append(n1)
	if has_node("Sprite2"):
		catchersp2 = $"Sprite2".duplicate()
		catchersp2.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp2)
	if has_node("Sprite3"):
		catchersp3 = $"Sprite3".duplicate()
		catchersp3.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp3)

func _on_Button_pressed():
	if $"Button".text == txt1 and freshPress == true:
		freshPress = false
		trialNum +=1
		#rng4.randomize()
		rng4.seed
		offset = 500 + rng4.randi_range(-35, 35)
		$"RichTextLabel".text = "Trial Number "+str(trialNum+1)+" of "+str(totalTrials)
		$"RichTextLabel3".text = "Payoff for this trial: "+str(FULLpayArr1[FULLindexArr1[trialNum]])
		$"Sprite2".visible = false
		$"Sprite3".visible = false
		for i4 in $"Catcher".get_children():
			i4.free()
		if has_node("Catcher/"+catchFolderName):
			get_node("Catcher/"+catchFolderName).free()
		if has_node("Catcher"):
			catchFolder = $"Catcher2".duplicate()
			catchFolder.set_name(catchFolderName)
			$"Catcher".add_child(catchFolder)
		for i2 in $"Node".get_children():
			i2.free()
		if has_node("Node/"+traceFolderName):
			get_node("Node/"+traceFolderName).free()
		if has_node("Node"):
			traceFolder = $"Node2".duplicate()
			traceFolder.set_name(traceFolderName)
			$"Node".add_child(traceFolder)
		spawnCookies()
		readyclick = 0
		catcheroutside = 0
		numcatchers = 0
		greenlist = []
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
		#spawnOne()
		spawnModes()
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


func _on_Button_mouse_entered():
	catcheroutside = 1


func _on_Button_mouse_exited():
	catcheroutside = 0
