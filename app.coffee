# Import file "finalMockups"
sketch = Framer.Importer.load("imported/finalMockups@1x", scale: 1)

Utils.globalLayers sketch


flow = new FlowComponent

flow.footer = Menu

flow.showNext(discover_FeaturedPlaces)

# Instantly show map around me on click 
Discover_mapButton.onClick ->
    flow.showNext(Discover_AroundMe, animate: false)
    
Discover_SoMa.onClick ->
	flow.showNext(SoMa)
	
	#static header
	flow.onMove ->
		SoMa_header_i.y = flow.scroll.scrollY 
		SoMa_header_i.animate
			shadowY: 2
			shadowBlur: 4
	
	SoMa_RP_1.onClick -> 
		flow.showNext(SF_Museum)
		flow.onMove ->
		SFMuseum_header.y = flow.scroll.scrollY 
		SFMuseum_header.animate
			shadowY: 2
			shadowBlur: 4
	
SoMa_backArrow_i.onClick ->
	flow.showPrevious()
	
	#RP horizontal scroll
scrollSoMa_RP1 = ScrollComponent.wrap(sketch.SoMa_RecommendedPlaces_content_i)
# Assign the content layers 
sketch.SoMa_RecommendedPlaces_content_i = scrollSoMa_RP1.content
scrollSoMa_RP1.scrollVertical = false
scrollSoMa_RP1.contentInset =
    top: 0
    bottom: 0
    right: 290
    left: 0
    
#SoMa food drink horzontal scroll
scrollSoMa_FD2 = ScrollComponent.wrap(sketch.SoMa_foodDrink_content_i)
# Assign the content layers 
sketch.SoMa_foodDrink_content_i= scrollSoMa_FD2.content
scrollSoMa_FD2.scrollVertical = false
scrollSoMa_FD2.contentInset =
    top: 0
    bottom: 0
    right: 290
    left: 0

#SoMa night life horzontal scroll
scrollSoMa_NL2 = ScrollComponent.wrap(sketch.SoMa_MusicNightlife_content_i)
# Assign the content layers 
sketch.SoMa_MusicNightlife_content_i= scrollSoMa_NL2.content
scrollSoMa_NL2.scrollVertical = false
scrollSoMa_NL2.contentInset =
    top: 0
    bottom: 0
    right: 290
    left: 0

AroundMe_listButton.onClick ->
    flow.showNext(discover_FeaturedPlaces, animate: false)

map_SoMa_active.visible = false
SoMa_popUpMenu1.visible = false
SoMa_popUpMenu1.y = 667

# # Custom transition 
# scaleTransition = (nav, layerB, overlay) ->
#     transition =
#         layerB:
#             show:
#                 y:500

map_SoMa_nonactive.onClick -> 
	map_SoMa_active.visible = true
# 	SoMaScrollingContent.visible = true 
# 	SoMaScrollingContent.animate
# 		y: 516.5
# 		time: 0.3
# 		options:
# 			curve: Spring(damping: 1)
	SoMa_popUpMenu1.visible = true 
	SoMa_popUpMenu1.animate
		y: 516.5
		time: 0.3
		options:
			curve: Spring(damping: 1)
	
			
map_SoMa_active.onClick -> 
	map_SoMa_active.visible = false
	SoMa_popUpMenu1.animate
		y: 667
		time: 0.3
		options:
			curve: Spring(damping: 1)

#dragging content
marketScroll = new ScrollComponent
	width: 375
	height: 600.5
	visible: false
# 	y: 57
marketScroll.scrollHorizontal = false
SoMaScrollingContent.parent = marketScroll.content
SoMaScrollingContent.visible = true
SoMaScrollingContent.y = 516.5

SoMa_popUpMenu1.draggable.enabled = true 
SoMa_popUpMenu1.draggable.horizontal = false
SoMa_directionsButton_main.visible = true

SoMa_popUpMenu1.onDragStart ->
	SoMa_popUpMenu1.visible = false
	marketScroll.visible = true
	SoMaScrollingContent.visible = true
	SoMa_upDown_arrow_3.rotation = 180
# 	print SoMaScrollingContent.y
	
# if SoMaScrollingContent.y is 0
# 	SoMa_upDown_arrow.rotation = 0

#creates stickiness
SoMa_header_1.position = SoMa_header_1.y

fullHeight = 500
headingHeight = 50

# Creating rules for sticky header on scroll
marketScroll.content.on "change:y", ->
	scrollY = marketScroll.scrollY
	if scrollY < SoMa_header_1.position + 516
		#stick header
		SoMa_header_1.y = SoMa_header_1.position
	
	else if scrollY > SoMa_header_1.position + 515
		SoMa_header_1.y = SoMa_header_1.position + scrollY - 516
# 	
# 	if scrollY > SoMa_header_1.position
# 		SoMa_header_1.y = SoMa_header_1.position + scrollY
# 		
# 		if scrollY > SoMa_header_1.position + (fullHeight - headingHeight) then SoMa_header_1.y = SoMa_header_1.position + (fullHeight - headingHeight)
# 		else SoMa_header_1.y = SoMa_header_1r.position + (scrollY - stickyHeader.position)
# 	
# 	else SoMa_header_1.y = SoMa_header_1.position

marketScroll.on Events.Scroll, (event, layer) ->
# 	print SoMa_header_1.position
# 	print scrollY
# 	print SoMa_header_1.y
	if marketScroll.content.y <= -516
		SoMa_upDown_arrow_3.animate
			rotation: 0
		SoMa_directionsButton_main.animate
			opacity:0
	else 
		SoMa_upDown_arrow_3.animate
			rotation: 180
		SoMa_directionsButton_main.animate
			opacity:1
		
	if marketScroll.content.y > 10 
		marketScroll.visible = false
		SoMa_popUpMenu1.visible = false  
		map_SoMa_active.visible = false
		
	if marketScroll.content.y is 0 
		SoMa_popUpMenu1.visible = true
		marketScroll.visible = false
		SoMaScrollingContent.visible = false
# 		map_SoMa_active.visible = false
	SoMa_header_1.animate
		shadowY: 2
		shadowBlur: 4

SoMa_upDown_arrow.onClick -> 
	SoMa_upDown_arrow_3.rotation = 180
	marketScroll.visible = true
	SoMaScrollingContent.visible = true
	marketScroll.content.animate
		y:-516

SoMa_upDown_arrow_3.onClick -> 
	SoMa_upDown_arrow_3.rotation = 180
	marketScroll.visible = true
	SoMaScrollingContent.visible = true
	marketScroll.content.animate
		y:-516

SoMa_upDown_arrow_3.onClick -> 
	SoMa_upDown_arrow_3.animate
		rotation: 180
	marketScroll.content.animate
		y:0
	SoMa_popUpMenu1.visible = true
# 	marketScroll.visible = false
# 	SoMaScrollingContent.visible = false

#RP horizontal scroll
scrollSoMa_RP = ScrollComponent.wrap(sketch.SoMa_RecommendedPlaces_content1)
# Assign the content layers 
sketch.SoMa_RecommendedPlaces_content1 = scrollSoMa_RP.content
scrollSoMa_RP.scrollVertical = false
scrollSoMa_RP.contentInset =
    top: 0
    bottom: 0
    right: 40
    left: 0
    
#SoMa food drink horzontal scroll
scrollSoMa_FD = ScrollComponent.wrap(sketch.SoMa_foodDrink_content1)
# Assign the content layers 
sketch.SoMa_foodDrink_content1= scrollSoMa_FD.content
scrollSoMa_FD.scrollVertical = false
scrollSoMa_FD.contentInset =
    top: 0
    bottom: 0
    right: 40
    left: 0

#SoMa night life horzontal scroll
scrollSoMa_NL = ScrollComponent.wrap(sketch.SoMa_MusicNightlife_content1)
# Assign the content layers 
sketch.SoMa_MusicNightlife_content1= scrollSoMa_NL.content
scrollSoMa_NL.scrollVertical = false
scrollSoMa_NL.contentInset =
    top: 0
    bottom: 0
    right: 40
    left: 0

#Click on Museum 
SoMa_RP_1_museum1.onClick ->
	flow.showNext(SF_Museum)
	marketScroll.animate
		x: -375
		options: 
			time: 0.5
			curve: Bezier.easeInOut
	SFMuseum_header.y = 0
	flow.onMove ->
		SFMuseum_header.y = flow.scroll.scrollY 
		SFMuseum_header.animate
			shadowY: 2
			shadowBlur: 4
# 	marketScroll.visible = false
# 	SoMaScrollingContent.visible = false

# scrollComp = ScrollComponent.wrap(SFMuseum_content)
# scrollComp.scrollHorizontal = false

# scrollComp.onScroll ->
# 	print scrollComp.content.y
# 	print scrollComp.scrollY
# 	print SFMuseum_header.y
# 	print SFMuseum_header.position
# 	SFMuseum_header.position = 0
# 	scrollY = scrollComp.scrollY
# 	if scrollY > SFMuseum_header.y
# 		SFMuseum_header.y = SFMuseum_header.y + scrollY
# 	flow.header = SFMuseum_header

# Creating rules for sticky header on scroll
	
SFMuseum_backButton.onClick ->
	flow.showPrevious(SoMa)
	marketScroll.animate
		x:0
		options: 
			time: 0.23
			curve: Bezier.ease

SFMuseum_star_active.visible = false

SFMuseum_star_nonactive.onClick ->
	SFMuseum_star_active.visible = true
	
SFMuseum_star_active.onClick ->
	SFMuseum_star_active.visible = false
	
SFMuseum_locationMap.onClick (event, layer) ->
	flow.showOverlayBottom(iOS_getDirections_menu)

#related horzontal scroll
scrollmuseum = ScrollComponent.wrap(sketch.SFMuseum_relatedPlaces_content)
# Assign the content layers 
sketch.SFMuseum_relatedPlaces_content = scrollmuseum.content
scrollmuseum.scrollVertical = false
scrollmuseum.contentInset =
    top: 0
    bottom: 0
    right: 300
    left: 0

SoMa_directionsButton_main.onClick (event, layer) ->	
	flow.showOverlayBottom(iOS_getDirections_menu)

SoMa_directionsButton2.onClick ->
	flow.showOverlayBottom(iOS_getDirections_menu)

Cancel_Button.onClick ->
	flow.showPrevious()

#menu
#dicover
#static header
flow.onMove ->
	Discover_fp_Header.y = flow.scroll.scrollY 
	Discover_fp_Header.animate
		shadowY: 2
		shadowBlur: 4

#hamburger click
hamburger_menu_main.onClick ->
# 	print "click menu"
	hamburger_menu_main_active.visible = true
	discover_main_nonactive.visible =true
# 	discover_main.visible = false
	flow.overlay.onClick ->
		flow.current.animate
			x: 0
			options: 
				time: 0.4
				curve: Bezier.ease
				
		flow.footer.animate
			x: 0
			options: 
				time: 0.4
				curve: Bezier.ease
		
		hamburger_menu_main_active.visible = false
		discover_main_nonactive.visible = false
				
	flow.showOverlayRight(sideMenu)
	flow.previous.animate
		x: -188
	flow.footer.animate
		x: -188
# 	print flow.current.name
# 	print a

menuButton_myPlaces.onClick ->
	flow.showPrevious()
	flow.showNext(myPlaces)
	flow.footer.visible = false
	
	flow.onMove ->
		myPlaces_header.y = flow.scroll.scrollY 
		myPlaces_header.bringToFront()
		myPlaces_header.animate
			shadowY: 2
			shadowBlur: 4
	
	place1.onClick ->
		flow.showNext(SF_Museum)
		flow.onMove ->
		SFMuseum_header.y = flow.scroll.scrollY 
		SFMuseum_header.animate
			shadowY: 2
			shadowBlur: 4
	
myPlaces_backIcon.onClick ->
	flow.showPrevious()
	flow.footer.visible = true
	flow.footer.animate
			x: 0
			options: 
				time: 0.5
				curve: Bezier.ease
	hamburger_menu_main_active.visible = false
	discover_main_nonactive.visible = false

menuButton_myInfo.onClick ->
	flow.showPrevious()
	flow.showNext(Menu_myInfo)
	flow.footer.visible = false

myInfo_backIcon.onClick ->
	flow.showPrevious()
	flow.footer.visible = true
	flow.footer.animate
			x: 0
			options: 
				time: 0.5
				curve: Bezier.ease
	hamburger_menu_main_active.visible = false
	discover_main_nonactive.visible = false

menuButton_settings.onClick ->
	flow.showPrevious()
	flow.showNext(menu_settings)
	flow.footer.visible = false

settings_backButton.onClick ->
	flow.showPrevious()
	flow.footer.visible = true
	flow.footer.animate
			x: 0
			options: 
				time: 0.5
				curve: Bezier.ease
	hamburger_menu_main_active.visible = false
	discover_main_nonactive.visible = false

myProfile_editButton.onClick ->
	flow.showNext(settings_edit_myprofile)

myProfile_backButton.onClick ->
	flow.showPrevious(menu_settings)

myProfile_applyButton.onClick ->
	flow.showPrevious(menu_settings)