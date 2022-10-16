extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var firstCatcherLeftEdge = "NA"
var firstCatcherRightEdge = "NA"
var secondCatcherLeftEdge = "NA"
var secondCatcherRightEdge = "NA"
var strListXs
var finalstrListXs
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
var SDmultiplierUnimodal=1

var txt1 = "Start Trial"
var txt1mid = "Answer Question"
var txt2 = "Adjust Catcher"
var txt3 = "See Result"
var txt3mid = "Display Graph"
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
var catchersp4
var catchersp5
var startingCatcherWidth = 0
var catcherCost

var readyclick = 0
var catcheroutside = 0
var offset
var numcatchers
var modesSaid
var greenlist
var greenlistCatcher1
var greenlistCatcher2
var caughtIn1 = 0
var caughtIn2 = 0
var drawGraph = false

var changeWidth = 0
var payoffTrial = 1000
var catchersPlaced = 0

var saveOutput = []
var timeElapsedSinceGameStart = 0
var timeElapsedSinceLastLog = 0
var http_client
var dataString = {"filename": "", "filedata":""}

func _draw():
	if drawGraph == true:
		var drawing = PoolVector2Array()
		var yPoint
		for i in range(-1000, 1000):
			yPoint = 200-(30000*(0.5*(1/(FULLdevArr1[FULLindexArr1[trialNum]]*1.41421*1.77245))*(pow(2.71828, (-0.5*(pow(((i-(FULLdisArr1[FULLindexArr1[trialNum]]/2))/FULLdevArr1[FULLindexArr1[trialNum]]), 2))))) + 0.5*(1/(FULLdevArr1[FULLindexArr1[trialNum]]*1.41421*1.77245))*(pow(2.71828, (-0.5*(pow(((i+(FULLdisArr1[FULLindexArr1[trialNum]]/2))/FULLdevArr1[FULLindexArr1[trialNum]]), 2)))))))
			drawing.push_back(Vector2(i+offset, yPoint))
		for index_point in range(1999):
			draw_line(drawing[index_point], drawing[index_point + 1], Color(1, 1, 1, 1))

func sum(arr:Array):
	var result = 0
	for i in arr:
		result+=i
	return result


# Called when the node enters the scene tree for the first time.
func _ready():
	print(global.catchersAllowed)
	print(global.numPlayed)
	print(global.playItertn)
	var jitter = randi() % 51 + 275
	$"Sprite2".position.y = jitter
	$"Sprite3".position.y = jitter
	$"Sprite4".position.y = jitter + 50
	$"Sprite5".position.y = jitter - 50
	$"Sprite4".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
	$"Sprite5".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
	$"Sprite4".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
	$"Sprite5".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
	global.playItertn += 1
	if (global.back2backDesign == 1):
		if global.playItertn == 1:
			global.win = 1000
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
	if typeof(trials1) == TYPE_INT:
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
	if typeof(trials1) == TYPE_ARRAY:
		totalTrials = len(devArr1)*len(proArr1)*len(catArr1)*len(payArr1)*len(samArr1)*sum(trials1)
		for i2 in len(disArr1):
			for i1 in int(trials1[i2]):
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
	saveOutput.append("timeStamp,numTrial,timeElapsedSinceGameStart,timeElapsedSinceLastLog,1stMode,2ndMode,StdDev,InitialPoints,1stCatcherLeftEdge,1stCatcherRightEdge,2ndCatcherLeftEdge,2ndCatcherRightEdge,FinalPoints,PerPointPayoff,1stCatcherPoints,2ndCatcherPoints,1stCatcherPayoff,2ndCatcherPayoff")
	timeElapsedSinceLastLog = 0
	http_client = HTTPClient.new()

func _make_post_request(url, data_to_send):
	var query = JSON.print(data_to_send)
	#var query = data_to_send
	var headers = ["Content-Type: application/json"]
	#http_client.connect_to_host("192.168.0.101", 8081)
	http_client.connect_to_host("https://maloneylabexperiments.hosting.nyu.edu")
	while(http_client.get_status() != 5):
		http_client.poll()
	http_client.poll()
	http_client.request(HTTPClient.METHOD_POST, url, headers, query)
	http_client.close()





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsedSinceGameStart = timeElapsedSinceGameStart + delta
	timeElapsedSinceLastLog = timeElapsedSinceLastLog + delta
	if $"Button".text == txt3:
		if catcheroutside == 0 and catchersPlaced < global.catchersAllowed:
			if Input.is_action_pressed("ui_right"):
				$"Sprite2".position.x +=1
				$"Sprite3".position.x +=1
			if Input.is_action_pressed("ui_left"):
				$"Sprite2".position.x -=1
				$"Sprite3".position.x -=1
			if Input.is_action_pressed("ui_up") and $"SpinBox2".value<=1000:
				$"SpinBox2".value +=1
			if Input.is_action_pressed("ui_down") and $"SpinBox2".value>=1:
				$"SpinBox2".value -=1
			$"Sprite3".position.x =$"Sprite2".position.x + 2*startingCatcherWidth
		else:
			$"Sprite2".position.x = -20
			$"Sprite3".position.x = -20
		#if InputEventMouseMotion:
		#	if catcheroutside == 0 and catchersPlaced < global.catchersAllowed:
		#		$"Sprite2".position.x = get_global_mouse_position().x - startingCatcherWidth
		#		$"Sprite3".position.x = get_global_mouse_position().x + startingCatcherWidth
		#	else:
		#		$"Sprite2".position.x = -20
		#		$"Sprite3".position.x = -20
		$"Sprite4".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
		$"Sprite5".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
		$"Sprite4".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
		$"Sprite5".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
		if Input.is_action_just_pressed("lmb"):
			readyclick = 1
		if Input.is_action_just_released("lmb") and readyclick == 1 and !($"Sprite3".position.x<0):
			readyclick = 0
			spawnOneCatcher()
			catchersPlaced = catchersPlaced + 1
			var jitter = randi() % 51 + 275
			$"Sprite2".position.y = jitter
			$"Sprite3".position.y = jitter
			$"Sprite4".position.y = jitter + 50
			$"Sprite5".position.y = jitter - 50
		if changeWidth == 1:
			startingCatcherWidth = int($"SpinBox2".value / 2)
			$"RichTextLabel2".visible = true
			$"Sprite6".visible = true
			$"RichTextLabel2".bbcode_text = "On placing new catcher, payoff per caught point will be: [b][i]"+str(payoffTrial-(int($"SpinBox2".value / 1))*1)+"[/i][/b]"
	else:
		$"RichTextLabel2".visible = false
		$"Sprite6".visible = false


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
				tempX = offset + int(rng2.randfn(0.0, (SDmultiplierUnimodal*FULLdevArr1[FULLindexArr1[trialNum]]))) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			else:
				tempX = offset + int(rng2.randfn(0.0, FULLdevArr1[FULLindexArr1[trialNum]])) - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
		else:
			if (global.back2backDesign == 1 and int(FULLdisArr1[FULLindexArr1[trialNum]]) == 0):
				tempX = offset + int(rng2.randfn(0.0, (SDmultiplierUnimodal*FULLdevArr1[FULLindexArr1[trialNum]]))) + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
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
	strListXs = ""
	print(str(FULLsamArr1[FULLindexArr1[trialNum]]))
	var howmany = 0
	for j in FULLsamArr1[FULLindexArr1[trialNum]]: 
		if has_node("Spritedot"):
			temp = $"Spritedot".duplicate()
			temp.set_name(generate_word(characters, 10))
			temp.position.x = getX()
			strListXs = strListXs + str(temp.position.x) + " "
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
		#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
		get_node("Node/"+traceFolderName).add_child(temp2)

func spawnTen():
	finalstrListXs = ""
	for abc in 10:
		if has_node("Spritedot2"):
			temp2 = $"Spritedot2".duplicate()
			temp2.set_name(generate_word(characters, 10))
			temp2.position.x = getX()
			finalstrListXs = finalstrListXs + str(temp2.position.x) + " "
			#temp2.position.y = randi() % 21 + 290
			temp2.position.y = 315 - 3*abc
			if (temp2.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				temp2.modulate = Color( 0, 1, 0, 1 )
			else:
				temp2.modulate = Color( 1, 0, 0, 1 )
			if (temp2.position.x in greenlistCatcher1):
				caughtIn1 += 1
			elif (temp2.position.x in (greenlistCatcher2)):
				caughtIn2 += 1
			# temp2.scale.y = 0.012
			#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
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
			# replacing numcatchers with modesSaid
			#if (numcatchers == 3 and temp2.position.x in greenlist and temp3.position.x in greenlist and temp4.position.x in greenlist):
			if (modesSaid == 3 and temp2.position.x in greenlist and temp3.position.x in greenlist and temp4.position.x in greenlist):
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
			#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp2)
			get_node("Node/"+traceFolderName).add_child(temp3)
			get_node("Node/"+traceFolderName).add_child(temp4)
	elif FULLdisArr1[FULLindexArr1[trialNum]] == 0:
		if has_node("Spritedot"):
			temp2 = $"Spritedot".duplicate()
			temp2.set_name(generate_word(characters, 10))
			temp2.position.x = offset
			# replacing numcatchers with modesSaid
			#if (numcatchers == 1 and temp2.position.x in greenlist):
			if (modesSaid == 1 and temp2.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				$"AudioStreamPlayerW".play()
				temp2.modulate = Color( 0, 1, 0, 1 )
			else:
				$"AudioStreamPlayerL".play()
				temp2.modulate = Color( 1, 0, 0, 1 )
			#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp2)
	else:
		if has_node("Spritedot"):
			temp3 = $"Spritedot".duplicate()
			temp3.set_name(generate_word(characters, 10))
			temp3.position.x = offset - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			temp4 = $"Spritedot".duplicate()
			temp4.set_name(generate_word(characters, 10))
			temp4.position.x = offset + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)
			# replacing numcatchers with modesSaid
			#if (numcatchers == 2 and temp3.position.x in greenlist and temp4.position.x in greenlist):
			if (modesSaid == 2 and temp3.position.x in greenlist and temp4.position.x in greenlist):
				global.win += FULLpayArr1[FULLindexArr1[trialNum]]
				$"AudioStreamPlayerW".play()
				temp3.modulate = Color( 0, 1, 0, 1 )
				temp4.modulate = Color( 0, 1, 0, 1 )
			else:
				$"AudioStreamPlayerL".play()
				temp3.modulate = Color( 1, 0, 0, 1 )
				temp4.modulate = Color( 1, 0, 0, 1 )
			#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
			get_node("Node/"+traceFolderName).add_child(temp3)
			get_node("Node/"+traceFolderName).add_child(temp4)

func spawnOneCatcher():
	global.win -= catcherCost
	#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
	print("catcher placed")
	numcatchers += 1
	if catchersPlaced == 0:
		firstCatcherLeftEdge = str($"Sprite2".position.x)
		firstCatcherRightEdge = str($"Sprite3".position.x)
	if catchersPlaced == 1:
		secondCatcherLeftEdge = str($"Sprite2".position.x)
		secondCatcherRightEdge = str($"Sprite3".position.x)
	for n1 in range($"Sprite2".position.x, $"Sprite3".position.x):
		greenlist.append(n1)
		if catchersPlaced == 0:
			greenlistCatcher1.append(n1)
		if catchersPlaced == 1:
			greenlistCatcher2.append(n1)
	payoffTrial = 1000 - greenlist.size()
	$"RichTextLabel3".text = "Current Payoff per caught point: "+str(payoffTrial)
	if has_node("Sprite2"):
		catchersp2 = $"Sprite2".duplicate()
		catchersp2.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp2)
	if has_node("Sprite3"):
		catchersp3 = $"Sprite3".duplicate()
		catchersp3.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp3)
	if has_node("Sprite4"):
		catchersp4 = $"Sprite4".duplicate()
		catchersp4.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp4)
	if has_node("Sprite5"):
		catchersp5 = $"Sprite5".duplicate()
		catchersp5.set_name(generate_word(characters, 10))
		get_node("Catcher/"+catchFolderName).add_child(catchersp5)

func _on_Button_pressed():
	if $"Button".text == txt1 and freshPress == true:
		$"ItemList".visible = false
		$"ItemList".clear()
		payoffTrial = 1000
		caughtIn1 = 0
		caughtIn2 = 0
		freshPress = false
		drawGraph = false
		#$"RichTextLabel2".text = "Total Balance in Dollars: "+str(global.win)
		update()
		trialNum +=1
		#rng4.randomize()
		rng4.seed
		offset = 500 + rng4.randi_range(-35, 35)
		catchersPlaced = 0
		$"RichTextLabel".text = "Trial Number "+str(trialNum+1)+" of "+str(totalTrials)
		#$"RichTextLabel3".text = "You get following dollar amount on winning this trial: "+str(FULLpayArr1[FULLindexArr1[trialNum]])
		$"RichTextLabel3".text = "Current Payoff per caught point: "+str(payoffTrial)
		$"Sprite2".visible = false
		$"Sprite3".visible = false
		$"Sprite4".visible = false
		$"Sprite5".visible = false
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
		firstCatcherLeftEdge = "NA"
		firstCatcherRightEdge = "NA"
		secondCatcherLeftEdge = "NA"
		secondCatcherRightEdge = "NA"
		readyclick = 0
		catcheroutside = 0
		numcatchers = 0
		greenlist = []
		greenlistCatcher1 = []
		greenlistCatcher2 = []
		$"AudioStreamPlayerS".play()
		#$"Button".text = txt1mid
		$"Button".text = txt2
	if $"Button".text == txt1mid and freshPress == true:
		$"ItemList".visible = false
		freshPress = false
		$"RichTextLabel4".visible = true
		modesSaid = 0
		$"SpinBox".value = 0
		$"SpinBox".visible = true
		$"Button".text = txt2
	if $"Button".text == txt2 and freshPress == true:
		var startingCatcherWidth = (randi() % 1000) + 1
		$"ItemList".visible = false
		freshPress = false
		modesSaid = $"SpinBox".value
		$"RichTextLabel4".visible = false
		$"SpinBox".visible = false
		$"RichTextLabel5".visible = true
		$"SpinBox2".value = startingCatcherWidth
		$"SpinBox2".visible = true
		changeWidth = 1
		#$"CheckBox".pressed = true
		#$"CheckBox".visible = true
		#$"CheckBox2".visible = true
		#$"CheckBox3".visible = true
		var randPosnCatcher = (randi() % 1000) + 1
		startingCatcherWidth = int(FULLcatArr1[FULLindexArr1[trialNum]]/2)
		catcherCost = startingCatcherWidth
		$"Sprite2".position.x = randPosnCatcher - startingCatcherWidth
		$"Sprite3".position.x = randPosnCatcher + startingCatcherWidth
		$"Sprite4".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
		$"Sprite5".position.x = ($"Sprite3".position.x + $"Sprite2".position.x)/2
		$"Sprite4".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
		$"Sprite5".scale.x = ($"Sprite3".position.x - $"Sprite2".position.x)
		$"Sprite2".visible = true
		$"Sprite3".visible = true
		$"Sprite4".visible = true
		$"Sprite5".visible = true
		$"Button".text = txt3
	if $"Button".text == txt3 and freshPress == true:
		freshPress = false
		$"RichTextLabel5".visible = false
		$"SpinBox2".visible = false
		#$"CheckBox".visible = false
		#$"CheckBox2".visible = false
		#$"CheckBox3".visible = false
		
		#spawnOne()
		#spawn modes as solution rather than a point from the distribution
		#spawnModes()
		#spawn 10 pts of distribution
		spawnTen()
		
		$"ItemList".visible = true
		$"ItemList".add_item(" ", null, false)
		$"ItemList".add_item("Points Caught", null, false)
		$"ItemList".add_item("Dollar Equivalent", null, false)
		$"ItemList".add_item("Catcher 1", null, false)
		$"ItemList".add_item(str(caughtIn1), null, false)
		$"ItemList".add_item(str(caughtIn1 * payoffTrial), null, false)
		$"ItemList".add_item("Catcher 2", null, false)
		$"ItemList".add_item(str(caughtIn2), null, false)
		$"ItemList".add_item(str(caughtIn2 * payoffTrial), null, false)
		$"ItemList".add_item("Total", null, false)
		$"ItemList".add_item(str(caughtIn1+caughtIn2), null, false)
		$"ItemList".add_item(str((caughtIn1+caughtIn2)*payoffTrial), null, false)
		
		if global.numPlayed == 1 and (trialNum+1) == 50: # this should always be 50 given there are atleast 50 test trials, because this is for one shot payment
			global.sess1var1 = str(caughtIn1)
			global.sess1var2 = str(caughtIn1 * payoffTrial)
			global.sess1var3 = str(caughtIn2)
			global.sess1var4 = str(caughtIn2 * payoffTrial)
			global.sess1var5 = str(caughtIn1+caughtIn2)
			global.sess1var6 = str((caughtIn1+caughtIn2)*payoffTrial)
		
		if global.numPlayed == 2 and (trialNum+1) == 50: # this should always be 50 given there are atleast 50 test trials, because this is for one shot payment
			global.sess2var1 = str(caughtIn1)
			global.sess2var2 = str(caughtIn1 * payoffTrial)
			global.sess2var3 = str(caughtIn2)
			global.sess2var4 = str(caughtIn2 * payoffTrial)
			global.sess2var5 = str(caughtIn1+caughtIn2)
			global.sess2var6 = str((caughtIn1+caughtIn2)*payoffTrial)
		
		var time2 = OS.get_time()
		var time_return2 = String(time2.hour) +":"+String(time2.minute)+":"+String(time2.second)
		saveOutput.append(time_return2+","+str(trialNum+1)+ "," + str(timeElapsedSinceGameStart) + "," + str(timeElapsedSinceLastLog) + "," + str(offset - int(FULLdisArr1[FULLindexArr1[trialNum]]/2)) + "," + str(offset + int(FULLdisArr1[FULLindexArr1[trialNum]]/2)) + "," + str(SDmultiplierUnimodal*FULLdevArr1[FULLindexArr1[trialNum]]) + "," + strListXs + "," + firstCatcherLeftEdge + "," + firstCatcherRightEdge + "," + secondCatcherLeftEdge + "," + secondCatcherRightEdge + "," + finalstrListXs + "," + str(payoffTrial) + "," + str(caughtIn1) + "," + str(caughtIn2) + "," + str(caughtIn1*payoffTrial) + "," + str(caughtIn2*payoffTrial) )
		timeElapsedSinceLastLog = 0
		
		if (global.playItertn == 1) or ("testing" in global.participCode):
			$"Button".text = txt3mid
		else:
			if (trialNum+1)==totalTrials:
				$"Button".text = "Main Screen"
			else:
				$"Button".text = txt1
	if $"Button".text == txt3mid and freshPress == true:
		$"ItemList".visible = false
		freshPress = false
		drawGraph = true
		update()
		if (trialNum+1)==totalTrials:
			$"Button".text = "Main Screen"
		else:
			$"Button".text = txt1
	if $"Button".text == "Main Screen" and freshPress == true:
		var datetime0 = OS.get_datetime()
		var filename_datetime0 = String(datetime0.year) +String(datetime0.month) +String(datetime0.day) +String(datetime0.hour) +String(datetime0.minute) +String(datetime0.second)
		if global.playItertn == 1 and global.numPlayed == 1:
			dataString.filename = "BIMODAL_dataFile_SingleCatcherTrainingTrials"+"_code_"+global.participCode+"_"+filename_datetime0+".csv"
		if global.playItertn == 2 and global.numPlayed == 1:
			dataString.filename = "BIMODAL_dataFile_SingleCatcherTestTrials"+"_code_"+global.participCode+"_"+filename_datetime0+".csv"
		if global.playItertn == 1 and global.numPlayed == 2:
			dataString.filename = "BIMODAL_dataFile_DoubleCatcherTrainingTrials"+"_code_"+global.participCode+"_"+filename_datetime0+".csv"
		if global.playItertn == 2 and global.numPlayed == 2:
			dataString.filename = "BIMODAL_dataFile_DoubleCatcherTestTrials"+"_code_"+global.participCode+"_"+filename_datetime0+".csv"
		dataString.filedata = (saveOutput)
		_make_post_request("/record_result.php", dataString)
		$"ItemList".visible = false
		freshPress = false
		drawGraph = false
		update()
		if (global.back2backDesign == 1):
			if global.playItertn == 1:
				get_tree().change_scene("res://Intermid.tscn")
			else:
				if global.numPlayed == 1:
					global.sess2var1 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.sess2var2 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.sess2var3 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.sess2var4 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.sess2var5 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.sess2var6 = str(0) # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					get_tree().change_scene("res://Closing.tscn") # keeping just one catcher game for now, remove this line and uncomment 'Menu2' for one+two cather game
					global.catchersAllowed = 2
					global.numPlayed = 2
					global.playItertn = 0
					# get_tree().change_scene("res://Menu2.tscn")
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


func _on_RichTextLabel5_mouse_entered():
	catcheroutside = 1


func _on_RichTextLabel5_mouse_exited():
	catcheroutside = 0


func _on_CheckBox_mouse_entered():
	catcheroutside = 1


func _on_CheckBox_mouse_exited():
	catcheroutside = 0


func _on_CheckBox2_mouse_entered():
	catcheroutside = 1


func _on_CheckBox2_mouse_exited():
	catcheroutside = 0


func _on_CheckBox3_mouse_entered():
	catcheroutside = 1


func _on_CheckBox3_mouse_exited():
	catcheroutside = 0


func _on_CheckBox_button_down():
	startingCatcherWidth = int(150/2)
	catcherCost = 150


func _on_CheckBox2_button_down():
	startingCatcherWidth = int(300/2)
	catcherCost = 250


func _on_CheckBox3_button_down():
	startingCatcherWidth = int(450/2)
	catcherCost = 300


func _on_SpinBox2_mouse_entered():
	catcheroutside = 1


func _on_SpinBox2_mouse_exited():
	catcheroutside = 0
