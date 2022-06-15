extends State

var speed
var velocity setget set_velocity,get_velocity
var applied_velocity setget set_applied_velocity,get_applied_velocity
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_velocity():
	return owner.velocity
	pass

func set_velocity(value):
	owner.velocity = value
	velocity = value
	pass

func get_applied_velocity():
	return owner.applied_velocity
	
func set_applied_velocity(value):
	owner.applied_velocity=value
	applied_velocity=value

func get_input_direction():
	var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	return input_direction
	
func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
