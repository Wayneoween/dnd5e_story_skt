---
---
up.compiler '.location-map', ($map, currentLocation) ->

	initialize = () ->
		$mapImage = $('<img src="/images/karte/faerun_north.jpg" class="xlarge">')
		$map.append($mapImage)
		addMarkerToCurrentLocation()
		# alert(distanceTo('Longsaddle'))
		# Uncomment the following lines to get the coordinates of a new location
		# by just clicking on it. Usefull for adding new locations.
		#$mapImage.on('click', showLocationCoordinates)

	coordinateMatrix = {
		'Conyberry': {x: 36.25, y: 43.42},
		'Triboar': {x: 41.95, y: 44.77},
		'Yatar': {x: 46.25, y: 44.28},
		'Longsaddle': {x: 38.98, y: 31.73},
	}

	distanceMatrix = [
		[null,			'Conyberry',	'Triboar',	'Yatar',	'Longsaddle'],
		['Conyberry', 	0, 				65,			125,		160],
		['Triboar',		65,				0,			60,			95],
		['Yatar',		125,			60,			0,			155],
		['Longsaddle',	160,			95,			155,		0],
	]

	addMarkerToCurrentLocation = () ->
		coordinates = coordinateMatrix[currentLocation]
		@$marker = $("<div class='location-map--marker' style='left: #{coordinates.x}%; top: #{coordinates.y}%;'></div>")
		$map.append($marker)

	locationIndex = (location) ->
		locations = distanceMatrix[0]
		index = _.findIndex(locations, (otherLocation) -> otherLocation == location)
		console.log("Could not find location #{location}") if index < 0
		index

	distanceTo = (location) ->
		distanceMatrix[locationIndex(currentLocation)][locationIndex(location)]

	showLocationCoordinates = (e) ->
		location = prompt("What's the name of this location?")
		coordinates = clickingCoordinates(e)
		alert("'#{location}': {x: #{coordinates.x}, y: #{coordinates.y}}")

	clickingCoordinates = (e) ->
		# Normalized percentual coordinates [x,y] in [0..100]²
		x = normalizeCoordinate(e.offsetX / e.target.clientWidth)
		y = normalizeCoordinate(e.offsetY / e.target.clientHeight)
		{x: x, y: y}

	normalizeCoordinate = (coordinate) ->
		_.round(coordinate * 100, 2)

	initialize()

	# walking days
	# riding days
	# flight time

	true