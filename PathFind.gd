extends Node

export var SPEED : int = 400
var path : = PoolVector2Array() setget set_path

onready var nav_2d  : Navigation2D = get_parent().get_node("Navigation2D")
onready var line_2d : Line2D = get_parent().get_node("Line2D")
onready var character : KinematicBody2D =  get_parent().get_node("KinematicBody2D")

func _ready() -> void:
	set_process(false)

func _unhandled_input(event : InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	var new_path : = nav_2d.get_simple_path(character.global_position,event.global_position, false)
	line_2d.points = new_path
	character.path = new_path

func _process(delta: float) -> void:
	var move_distance : = SPEED * delta
	move_along_path(move_distance)

func move_along_path( distance : float) -> void:
	var starting_point : = character.position
	for i in range(path.size()) :
		var distance_to_next : = starting_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			character.position = starting_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0 :
			character.position = path[0]
			set_process(false)
		distance -= distance_to_next
		starting_point = path[0]
		path.remove(0)
		

	
func set_path( value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0 :
		return
	set_process(true)
