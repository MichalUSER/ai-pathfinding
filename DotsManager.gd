extends Node2D

var dot = preload("res://Dot.tscn")
onready var startpoint = get_node("../Startpoint").position
onready var endpoint = get_node("../Endpoint").position
onready var dotstrainer = get_node("../DotsTrainer")

var numberOfDots = 200
var aliveDots = 0
var counter = 0

func removeDot(data):
	aliveDots -= 1
	dotstrainer.dots.append(data)

func generateMoves(numberOfMoves):
	var moves = []
	for i in range(numberOfMoves):
		moves.append(randi()%360)
	return moves

func spawnDot(moves):
	aliveDots += 1
	var dotInstance = dot.instance()
	dotInstance.position = startpoint
	dotInstance.endpoint = endpoint
	dotInstance.moves = moves
	call_deferred("add_child", dotInstance)

func _ready():
	for i in range(numberOfDots):
		spawnDot(generateMoves(randi()%600+20))
