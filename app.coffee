# Import file "finalMockups"
sketch = Framer.Importer.load("imported/finalMockups@1x", scale: 1)

Utils.globalLayers sketch

Utils.insertCSS("
	
	.tSize {
		font-size: 24px 
	}
	
")

nameInput.html = "<input type=text placeholder='Name' style='padding:7px 0px; margin-top: 0px; margin-left: 3px; font-size: 20px; font-family: Circular Std'>"
purposeDropdown.html = "<select style='-webkit-appearance: none; background: transparent; border: none; font-size: 20px; font-family: Circular Std; height: 29px; width: 280px;  background: url() no-repeat right center; margin-top: 7px'><option>Study</option><option>Work</option></select>"
timeDropdown.html = "<select style='-webkit-appearance: none; background: transparent; border: none; font-size: 20px; font-family: Circular Std; height: 29px; width: 160px;  background: url() no-repeat right center; margin-top: 7px'><option>Weeks</option><option>Months</option></select>"
time.html = "<input type=text placeholder='Time' style='padding:7px 0px; width: 100px; margin-top: 0px; margin-left: 3px; font-size: 20px; font-family: Circular Std'>"

#enjoy buttons
enjoy = [parks, culturalHistory, games, hiking, museums, movies, magazines, architecture, animals, theatre, pizza, books, cafes]

for i in [0...enjoy.length]
	
	enjoy[i].states = 
		on:
			opacity: 1
		off:
			opacity: 0
			
	enjoy[i].onClick ->
		if this.states.current.name == "default"
			this.stateSwitch("on")
		
		if this.states.current.name == "on"
			this.stateSwitch("off")
		else 
			this.stateSwitch("on")

#minutes options
localMins.onClick ->
	localMins.visible = false
	localMins1.visible = true
	
	internationalMins.visible = true 
	bothMins.visible = true 

localMins1.onClick ->
	localMins.visible = true 
	localMins1.visible = false

internationalMins.onClick ->
	internationalMins.visible = false 
	internationalMins1.visible = true
	
	localMins.visible = true 
	bothMins.visible = true 

internationalMins1.onClick ->
	internationalMins.visible = true 
	internationalMins1.visible = false 

bothMins.onClick ->
	bothMins.visible = false 
	bothMins1.visible = true 
	
	localMins.visible = true 
	internationalMins.visible = true 

bothMins1.onClick ->
	bothMins.visible = true
	bothMins1.visible = false  
 
 #messages options
textLocalMins.onClick ->
	textLocalMins.visible = false
	textLocalMins1.visible = true
	
	textInternationalMins.visible = true 
	textBothMins.visible = true 

textLocalMins1.onClick ->
	textLocalMins.visible = true 
	textLocalMins1.visible = false

textInternationalMins.onClick ->
	textInternationalMins.visible = false 
	textInternationalMins1.visible = true
	
	textLocalMins.visible = true 
	textBothMins.visible = true 

textInternationalMins1.onClick ->
	textInternationalMins.visible = true 
	textInternationalMins1.visible = false 

textBothMins.onClick ->
	textBothMins.visible = false 
	textBothMins1.visible = true 
	
	textLocalMins.visible = true 
	textInternationalMins.visible = true 

textBothMins1.onClick ->
	textBothMins.visible = true
	textBothMins1.visible = false  
	
# #home swipes
# #SSN swipe
# SSN3.draggable.enabled = true 
# SSN3.draggable.vertical = false 				
# 		
# SSN3.on Events.DragEnd, ->
# 	if SSN3.x < -30
# 		SSN3.animate 
# 			properties:
# 				x: -112
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 	else 
# 		SSN3.animate
# 			properties:
# 				x: 0
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 
# #mobile phone swipe
# mobilePhone.draggable.enabled = true 
# mobilePhone.draggable.vertical = false 				
# 		
# mobilePhone.on Events.DragEnd, ->
# 	if mobilePhone.x < -30
# 		mobilePhone.animate 
# 			properties:
# 				x: -112
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 	else 
# 		mobilePhone.animate
# 			properties:
# 				x: 0
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 
# #bank swipe
# bank.draggable.enabled = true 
# bank.draggable.vertical = false 				
# 		
# bank.on Events.DragEnd, ->
# 	if bank.x < -30
# 		bank.animate 
# 			properties:
# 				x: -112
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 	else 
# 		bank.animate
# 			properties:
# 				x: 0
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 
# #emergency services swipe				
# emergencyServices.draggable.enabled = true 
# emergencyServices.draggable.vertical = false 				
# 		
# emergencyServices.on Events.DragEnd, ->
# 	if emergencyServices.x < -30
# 		emergencyServices.animate 
# 			properties:
# 				x: -112
# 				curve: "spring(1000,40)"
# 				time: 0.1
# 	else 
# 		emergencyServices.animate
# 			properties:
# 				x: 0
# 				curve: "spring(1000,40)"
# 				time: 0.1

#drag and drop
tiles = [applyForSSN, getMobilePhone, findBank, emergencyServices1]
heightVal = 124
startIndex = null

sortVertically = (array) ->
	for bo, t in array
		bo.animateStop()
		if bo.draggable.isDragging is false 
			bo.animate properties:
				y: heightVal * t 
			
updateIndex = (layer, array) ->
	midYs = array.map (i) -> i.midY
	
	if midYs[startIndex] <= midYs[startIndex-1]
		array.splice(startIndex, 1)
		array.splice(startIndex-1, 0, layer)
		startIndex = array.indexOf(layer)
		sortVertically(array)
	else if midYs[startIndex] >= midYs[startIndex+1]
		array.splice(startIndex, 1)
		array.splice(startIndex+1, 0, layer)
		startIndex = array.indexOf(layer)
		sortVertically(array)

for i in [0...tiles.length]	

	tiles[i].draggable = true 
	
	tiles[i].on Events.LongPress, (event) ->
		this.bringToFront()
# 		this.draggable = true
		
		startIndex = tiles.indexOf(this)
		
		this.animate	
			properties:
				scale: 1.1
				shadow: 4
				shadowBlur: 15
				shadowColor: "rgba(0,0,0,0.2)"
	
	tiles[i].on Events.DragMove, (event, layer) ->
		updateIndex(layer, tiles)
		sortVertically(tiles)
	
	tiles[i].on Events.DragEnd, (event, layer) ->
		this.animate properties:
			x: 0
			y: heightVal * (tiles.indexOf(this))
			scale: 1
			shadow: 0
			shadowBlur: 0


flow = new FlowComponent
flow.showNext(PhonePlanFilter1)
mainIndicator.visible = false
flow.backgroundColor = "white"

#onboarding Flow
onboardingMainNext.onClick ->
	flow.showNext(onboarding2)
	activateDot(1)
				
onboarding2Next.onClick ->
	flow.showNext(onboarding3)
	
onboarding2Back.onClick ->
	flow.showPrevious(onboardingMain)

onboarding3Next.onClick ->
	flow.showNext(onboarding4)
	
onboarding3Back.onClick ->
	flow.showPrevious(onboarding2)

onboarding4Next.onClick ->
	flow.showNext(onboarding5)
	
onboarding4Back.onClick ->
	flow.showPrevious(onboarding3)

onboarding5Next.onClick ->
	flow.showNext(onboarding6)
	
onboarding5Back.onClick ->
	flow.showPrevious(onboarding4)

onboarding6Back.onClick ->
	flow.showPrevious(onboarding5)

readyButton.onClick ->
	flow.showNext(home)
	mainIndicator.visible = false 

flow.footer = mainMenu 
flow.footer.visible = false 


#onboarding indicators
mainIndicator.index = 30
mainIndicator.x = 135
mainIndicator.y = 587

activateDot = (index) ->
	mainIndicator.children[index].animate 
		opacity: 1

flow.onTransitionEnd ->
	for dot in mainIndicator.children
		dot.animate
			opacity: 0.25
			
	if flow.current is onboardingMain
		activateDot(0)
		
	if flow.current is onboarding2
		activateDot(1)
	
	if flow.current is onboarding3
		activateDot(2)

	if flow.current is onboarding4
		activateDot(3)
	
	if flow.current is onboarding5
		activateDot(4)

	if flow.current is onboarding6
		activateDot(5)
		

	
	

#phone plan filter 1 slider 

round = (number, nearest) -> Math.round(number / nearest) * nearest

#data slider
slider = new SliderComponent
	x: Align.center 
	y: 245
	min: 0
	max: 100
	value: 50 
	width: 300
	height: 3
	backgroundColor: "#55ABF8"

slider.knobSize = 17
slider.knob.backgroundColor = "#55ABF8"

slider.fill.backgroundColor = "#55ABF8"

slider.knob.draggable.updatePosition = (point) ->
	point.x = round(point.x, slider.width / (10)) - (slider.knobSize / 2)
	return point

dataSliderText = new Layer
	html: "500<span class='tSize'>MB</span>"
	color: "black"
	backgroundColor: ""
	x: Align.center
	y: 195
dataSliderText.style = 
	textAlign: "center"
	fontFamily: "Circular"
	fontStyle: "bold"
	fontSize: "48px"
# slider.fill.backgroundColor = "black"
slider.bringToFront()

slider.onValueChange ->
	if slider.value == 0
		dataSliderText.html = "0<span class='tSize'>MB</span>"
	if slider.value == 10
		dataSliderText.html = "50<span class='tSize'>MB</span>"
	if slider.value == 20
		dataSliderText.html = "100<span class='tSize'>MB</span>"
	if slider.value == 30
		dataSliderText.html = "200<span class='tSize'>MB</span>"
	if slider.value == 40
		dataSliderText.html = "500<span class='tSize'>MB</span>"
	if slider.value == 50
		dataSliderText.html = "1<span class='tSize'>GB</span>"
	if slider.value == 60
		dataSliderText.html = "2<span class='tSize'>GB</span>"
	if slider.value == 70
		dataSliderText.html = "3<span class='tSize'>GB</span>"
	if slider.value == 80
		dataSliderText.html = "5<span class='tSize'>GB</span>"
	if slider.value == 90
		dataSliderText.html = "10<span class='tSize'>GB</span>"
	if slider.value == 100
		dataSliderText.html = "Unlimited"

#minutes slider
slider1 = new SliderComponent
	x: Align.center 
	y: 528
	min: 0
	max: 100
	value: 50 
	width: 300
	height: 3
	backgroundColor: "#55ABF8"

slider1.knobSize = 17
slider1.knob.backgroundColor = "#55ABF8"

slider1.fill.backgroundColor = "#55ABF8"

slider1.knob.draggable.updatePosition = (point) ->
	point.x = round(point.x, slider.width / (10)) - (slider.knobSize / 2)
	return point

minutesSliderText = new Layer
	html: "400"
	color: "black"
	backgroundColor: ""
	x: Align.center
	y: 480
minutesSliderText.style = 
	textAlign: "center"
	fontFamily: "Circular"
	fontStyle: "bold"
	fontSize: "48px"

slider1.onValueChange ->
	if slider1.value == 0
		minutesSliderText.html = "0"
	if slider1.value == 10
		minutesSliderText.html = "50"
	if slider1.value == 20
		minutesSliderText.html = "100"
	if slider1.value == 30
		minutesSliderText.html = "200"
	if slider1.value == 40
		minutesSliderText.html = "300"
	if slider1.value == 50
		minutesSliderText.html = "400"
	if slider1.value == 60
		minutesSliderText.html = "500"
	if slider1.value == 70
		minutesSliderText.html = "1000"
	if slider1.value == 80
		minutesSliderText.html = "1500"
	if slider1.value == 90
		minutesSliderText.html = "2000"
	if slider1.value == 100
		minutesSliderText.html = "Unlimited"

#messages slider
slider2 = new SliderComponent
	x: Align.center 
	y: 362
	min: 0
	max: 100
	value: 50 
	width: 300
	height: 3
	backgroundColor: "#55ABF8"

slider2.knobSize = 17
slider2.knob.backgroundColor = "#55ABF8"

slider2.fill.backgroundColor = "#55ABF8"

slider2.knob.draggable.updatePosition = (point) ->
	point.x = round(point.x, slider.width / (10)) - (slider.knobSize / 2)
	return point

messagesSliderText = new Layer
	html: "750"
	color: "black"
	backgroundColor: ""
	x: Align.center
	y: 315
messagesSliderText.style = 
	textAlign: "center"
	fontFamily: "Circular"
	fontStyle: "bold"
	fontSize: "48px"

slider2.onValueChange ->
	if slider2.value == 0
		messagesSliderText.html = "0"
	if slider2.value == 10
		messagesSliderText.html = "50"
	if slider2.value == 20
		messagesSliderText.html = "100"
	if slider2.value == 30
		messagesSliderText.html = "250"
	if slider2.value == 40
		messagesSliderText.html = "500"
	if slider2.value == 50
		messagesSliderText.html = "750"
	if slider2.value == 60
		messagesSliderText.html = "1000"
	if slider2.value == 70
		messagesSliderText.html = "1500"
	if slider2.value == 80
		messagesSliderText.html = "2000"
	if slider2.value == 90
		messagesSliderText.html = "3000"
	if slider2.value == 100
		messagesSliderText.html = "Unlimited"
slider2.visible = false 
messagesSliderText.visible = false
		
needsScroll = ScrollComponent.wrap(needsInactive)
sketch.needsInactive = needsScroll.content
needsScroll.scrollHorizontal = false
needsScroll.contentInset = 
	bottom: 80

#needs buttons
needs = [SSN1, bankAccount, embassy, transitOptions, phonePlan, pharmacy, laundromat, emergencyServices, medicalInsurance, doctor, groceryStores, postOffice, worship]

for i in [0...needs.length]

	needs[i].states =
		on:
			opacity: 1
		off:
			opacity: 0
	
	needs[i].on Events.Click, (event, layer) ->
		unless needsScroll.isMoving						#only run the following coce if it's not scrolling
			if this.states.current.name == "default"
				this.stateSwitch("on")
			if this.states.current.name == "on"
				this.stateSwitch("off")
			else 
				this.stateSwitch("on")

# homeScrolls= ScrollComponent.wrap(homeScroll)
# sketch.homeScroll = homeScrolls.content
# homeScrolls.scrollHorizontal = false 
# homeScrolls.scrollVertical = false
# homeScrolls.contentInset = 
# 	bottom: 80
	
#general app flow 
applyForSSN.onClick ->
	flow.showNext(SSNPage)

SSNPageBack.onClick ->
	flow.showPrevious(home)

getMobilePhone.onClick ->
	flow.showNext(PhonePlanFilter1)
	flow.footer.visible = false 
	
phonePlanFilter1Back.onClick ->
	flow.showPrevious(home)
	flow.footer.visible = true

phonePlanNext.onClick ->
	flow.showNext(PhonePlanFilter2)
	slider.visible = false 
	slider1.visible = false 
	minutesSliderText.visible = false 
	dataSliderText.visible = false 
	slider2.visible = true 
	messagesSliderText.visible = true 

phonePlanSkip1.onClick ->
	flow.showNext(mobilePlan)
	flow.footer.visible = true 
	slider.visible = false 
	slider1.visible = false 
	minutesSliderText.visible = false 
	dataSliderText.visible = false 
	
