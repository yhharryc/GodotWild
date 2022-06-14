extends KinematicBody2D

export(float) var max_walk_speed = 450
export(float) var max_run_speed = 700
export(float) var gravity = -9.8
var velocity = Vector2()
signal direction_changed(new_direction)

var look_direction = Vector2.RIGHT setget set_look_direction
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func get_walk_speed()->float:
	return max_walk_speed
	pass

func get_current_state():
	return $StateMachine.current_state


func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func is_grounded():
	return is_on_floor()
	
