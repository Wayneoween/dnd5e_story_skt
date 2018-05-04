---
---
up.compiler '.location_map', ($element, currentLocation) ->
	distanceMatrix = [
		[null,			'Cranberry',	'Triboar',	'Yatar',	'Longsaddle'],
		['Conyberry', 	0, 				65,			125,		160],
		['Triboar',		65,				0,			60,			95],
		['Yatar',		125,			60,			0,			155],
		['Longsaddle',	160,			95,			155,		0],
	]

	locationIndex = (location) ->
		locations = distanceMatrix[0]
		index = _.findIndex(locations, (otherLocation) -> otherLocation == location)
		console.log("Could not find location #{location}") if index < 0
		index

	distanceTo = (location) ->
		distanceMatrix[locationIndex(currentLocation)][locationIndex(location)]

	# alert(distanceTo('Longsaddle'))

	# walking days
	# riding days
	# flight time

	true