---
---
up.compiler '.location-map', ($map, currentLocation) ->

	ZOOMFACTOR = 2.5
	isZoomed = false

	initialize = ->
		initializeDom()
		initializeHandlers()

	initializeDom = ->
		@$wrapper = $("<div class='location-map--image-wrapper'></div>")
		@$mapImage = $('<img src="/images/karte/faerun_north.jpg" class="location-map--image">')
			.load ->
				addMarkerToCurrentLocation()
		@$marker = $("<div class='location-map--marker pin' style='display: none;'></div>")
		$wrapper.append($mapImage)
		$wrapper.append($marker)
		$map.append($wrapper)

	initializeHandlers = ->
		$wrapper.on('dblclick dbltap', toggleZoom)
		$(window).resize(addMarkerToCurrentLocation)

		# Uncomment the following lines to get the coordinates of a new location
		# by just clicking on it. Usefull for adding new locations.
		# $mapImage.on('click', showLocationCoordinates)

	toggleZoom = (e) ->
		isZoomed = !isZoomed
		if isZoomed
			$wrapper.on('click tap', navigateOnMap)
			navigateOnMap(e)
		else
			$wrapper[0].style.transform = "scale(1)"
			$wrapper.off('click tap', navigateOnMap)

	navigateOnMap = (e) ->
		offset = zoomImageOffset(e)
		$wrapper[0].style.transform = "scale(#{ZOOMFACTOR}) translateX(#{offset.x}px) translateY(#{offset.y}px)"

	zoomImageOffset = (e) ->
		# The top left ankered zoom rectangle should be aligned with the now
		# ZOOMFACTOR smaller image.
		xOffset = mapBoundryOffset(e.target.clientWidth, e.offsetX)
		yOffset = mapBoundryOffset(e.target.clientHeight, e.offsetY)
		{x: xOffset, y: yOffset}

	mapBoundryOffset = (maxLength, offset) ->
		zoomedBoxLength = maxLength / ZOOMFACTOR
		leftBorder = 0
		rightBorder = maxLength - zoomedBoxLength
		zoomedOffset = offset - zoomedBoxLength / 2
		- Math.min(Math.max(zoomedOffset, leftBorder), rightBorder)

	coordinateMatrix = {
		'Amphail': {x: 38.67, y: 71.96},
		'Ascore': {x: 88.44, y: 24.11},
		'Aurilssbarg': {x: 4.77, y: 15.87},
		'Bargewright Inn': {x: 43.28, y: 67.9},
		'Beliard': {x: 46.33, y: 57.2},
		#'Beorunna\'s Well': {x: 67.89, y: 8.49},
		'Calling Horns': {x: 53.91, y: 42.07},
		'Carnath Roadhouse': {x: 32.66, y: 61.25},
		'Citadel Adbar': {x: 83.59, y: 16.73},
		'Citadel Felbarr': {x: 71.02, y: 20.05},
		'Daggerford': {x: 45.63, y: 87.95},
		'Deadsnows': {x: 79.38, y: 21.53},
		#'Deadstone Cleft': {x: 78.83, y: 63.96},
		'Everlund': {x: 63.05, y: 32.96},
		'Auge des Allvaters': {x: 42.73, y: 6.27},
		'Fireshear': {x: 14.22, y: 19.8},
		#'Flint Rock': {x: 49.14, y: 38.38},
		'Gauntlgrym': {x: 29.06, y: 30.63},
		'Goldenfields': {x: 42.58, y: 71.96},
		#'Grandfather Tree': {x: 65.39, y: 42.07},
		#'Great Worm Cavern': {x: 46.64, y: 7.13},
		'Griffon\'s Nest': {x: 43.52, y: 27.55},
		#'Grudd Haug': {x: 48.28, y: 64.7},
		'Hawk\'s Nest': {x: 66.33, y: 24.97},
		'Helm\'s Hold': {x: 26.72, y: 40.84},
		'Hundelstone': {x: 16.09, y: 13.16},
		'Ironmaster': {x: 13.83, y: 10.7},
		'Ironslag': {x: 76.88, y: 9.47},
		#'Iymrith\'s Lair': {x: 90.86, y: 21.89},
		'Julkoun': {x: 51.33, y: 85.61},
		'Kheldell': {x: 36.72, y: 63.84},
		'Leilon': {x: 29.61, y: 55.23},
		'Llorkh': {x: 76.02, y: 74.54},
		'Longsaddle': {x: 38.98, y: 31.73},
		'Loudwater': {x: 66.25, y: 73.43},
		'Lurkwood': {x: 37.38, y: 20.62},
		'Luskan': {x: 23.13, y: 24.35},
		'Mines of Mirabar': {x: 32.89, y: 12.67},
		'Mirabar': {x: 34.38, y: 15.62},
		'Mithral Hall': {x: 54.37, y: 20.54},
		#'Morgur\'s Mound': {x: 32.5, y: 25.09},
		'Mornbryn\'s Shield': {x: 46.41, y: 35.18},
		'Nesmé': {x: 51.17, y: 27.43},
		'Neverwinter': {x: 26.02, y: 40.22},
		'Newfort': {x: 75.16, y: 24.72},
		'Nightstone': {x: 41.64, y: 80.93},
		'Noanar\'s Hold': {x: 55.63, y: 44.28},
		'Olostin\'s Hold': {x: 61.41, y: 36.65},
		#'One Stone': {x: 64.61, y: 14.51},
		'Orlbar': {x: 71.41, y: 70.11},
		'Parnast': {x: 84.84, y: 78.23},
		'Phandalin': {x: 32.19, y: 52.15},
		'Port Llast': {x: 24.45, y: 35.55},
		'Rassalantar': {x: 37.89, y: 74.54},
		#'Raven Rock': {x: 25.7, y: 10.95},
		'Red Larch': {x: 40.47, y: 60.76},
		'Rivermoot': {x: 53.28, y: 24.23},
		'Secomber': {x: 56.02, y: 81.43},
		'Senteq\'s Hut': {x: 72, y: 41.79},
		'Shadowtop Cathedral': {x: 59.38, y: 43.79},
		#'Shining White': {x: 45.63, y: 25.22},
		'Silverymoon': {x: 62.19, y: 28.17},
		'Starmetal Hills': {x: 37.5, y: 35},
		'Stone Bridge': {x: 45.23, y: 56.46},
		#'Stone Stand': {x: 70, y: 34.44},
		'Sundabar': {x: 72.03, y: 27.06},
		#'Svardborg': {x: 6.8, y: 8.61},
		'Thornhold': {x: 31.64, y: 65.56},
		'Triboar': {x: 41.88, y: 44.9},
		'Uluvin': {x: 54.3, y: 73.43},
		'Waterdeep': {x: 38.98, y: 79.46},
		'Way Inn': {x: 48.75, y: 96.68},
		'Westbridge': {x: 41.72, y: 52.52},
		'Womford': {x: 43.91, y: 68.14},
		'Xantharl\'s Keep': {x: 36.02, y: 21.89},
		'Yartar': {x: 46.25, y: 44.4},
		'Zelbross': {x: 61.64, y: 77.74},
		'Zymorven Hall': {x: 57.66, y: 25.34},
	}

	addMarkerToCurrentLocation = () ->
		coordinates = deNormalizeCoordinates(coordinateMatrix[currentLocation])
		$marker.css('left', "#{coordinates.x}px")
		$marker.css('top', "#{coordinates.y}px")
		$marker.fadeIn('fast')

	showLocationCoordinates = (e) ->
		location = prompt("What's the name of this location?")
		coordinates = relativeClickingCoordinates(e)
		if location
			alert("'#{location}': {x: #{coordinates.x}, y: #{coordinates.y}},")

	relativeClickingCoordinates = (e) ->
		# Normalized percentual coordinates [x,y] in [0..100]²
		x = normalizeCoordinate(e.offsetX / e.target.clientWidth)
		y = normalizeCoordinate(e.offsetY / e.target.clientHeight)
		{x: x, y: y}

	normalizeCoordinate = (coordinate) ->
		_.round(coordinate * 100, 2)

	deNormalizeCoordinates = (percentualCoordinates) ->
		{
			x: percentualCoordinates.x * $mapImage[0].clientWidth / 100,
			y: percentualCoordinates.y * $mapImage[0].clientHeight / 100
		}

	initialize()

	# Ideas:
	# walking days
	# riding days
	# flight time

	true
