extends KinematicBody2D

var endpoint = Vector2()
var velocity = Vector2()
var changeRate = 20
var speed = 350
var counter = 0
var index = 0

onready var scene = get_tree().get_current_scene()

var fitness = 0
var moves = []
onready var movesLength = moves.size()

func calculateFitness():
	var distanceToGoal = position.distance_to(endpoint)
	if distanceToGoal < 180:
		var movesSize = moves.size()
		fitness = 1.0 / (movesSize * movesSize)
	else:
		fitness = 1.0 / (distanceToGoal * distanceToGoal)
	
func die():
	scene.get_node("DotsManager").removeDot([fitness, moves])
	queue_free()

func _physics_process(delta):
	if counter == changeRate:
		if index + 1 == movesLength:
			die()
		set_rotation_degrees(moves[index])
		index += 1
		counter = 0
	else:
		counter += 1
	velocity = Vector2(speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	calculateFitness()
	
	if get_slide_count() >= 1:
		die()
