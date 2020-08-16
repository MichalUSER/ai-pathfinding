extends Node2D

onready var dotsmanager = get_node("../DotsManager")
onready var label = get_node("../Label")

var dots = []
var gen = 0

var mutationRate = 0.1

func calculateFitnessSum():
	var fitnessSum = 0
	for dot in dots:
		fitnessSum += dot[0]
	return fitnessSum

func naturalSelection(fitnessSum):
	var randomNumber = rand_range(0, fitnessSum)
	var runningSum = 0
	for dot in dots:
		runningSum += dot[0]
		if runningSum > randomNumber:
			return dot[1]

func mutate(moves):
	var movesCopy = []
	for move in moves:
		randomize()
		var randomNumber = rand_range(0, 1)
		if randomNumber < mutationRate:
			randomize()
			movesCopy.append(randi()%360)
		else:
			movesCopy.append(move)
	return movesCopy

func _process(delta):
	if dotsmanager.aliveDots == 0:
		var fitnessSum = calculateFitnessSum()
		dotsmanager.spawnDot(naturalSelection(fitnessSum))
		for i in range(dotsmanager.numberOfDots - 1):
			dotsmanager.spawnDot(mutate(naturalSelection(fitnessSum)))
		dots.clear()
		gen += 1
		label.text = "Generation: " + str(gen)
