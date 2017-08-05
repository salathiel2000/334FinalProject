# Import file "finalMockups"
sketch = Framer.Importer.load("imported/finalMockups@1x", scale: 1)

Utils.globalLayers sketch

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

flow = new FlowComponent
flow.showNext(onboardingMain)

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