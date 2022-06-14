extends "res://game/scripts/state_machine/states/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_gravity(y):
	
	return min(y + owner.gravity*(-1), 200)
	pass


func update(_delta):

	var input_direction = get_input_direction()
	speed = owner.get_walk_speed()
	if not self.velocity:
		self.velocity = Vector2()
	self.velocity = Vector2(input_direction.x*speed,calculate_gravity(self.velocity.y))
	owner.move_and_slide(self.velocity, Vector2.UP, 5, 2)
	update_look_direction(input_direction)
	if owner.is_grounded():
		emit_signal("finished","idle")
	pass
