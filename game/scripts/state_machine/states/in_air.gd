extends "res://game/scripts/state_machine/states/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_gravity(y):
	var previous_y = self.velocity.y
	self.velocity.y = self.velocity.y 
	#return min(y + owner.gravity*(-1), 200)
	return y + owner.gravity*(-1)
	pass


func update(_delta):
	var input_direction = get_input_direction()
	speed = owner.get_walk_speed()
	if not self.velocity:
		self.velocity = Vector2()
#	self.velocity = Vector2(input_direction.x*speed,calculate_gravity(self.velocity.y))
	self.applied_velocity.x = input_direction.x * speed 
	handle_gravity()
	
	update_look_direction(input_direction)
	if owner.is_grounded():
		emit_signal("finished","idle")
	pass

func handle_gravity():
#	var previous_y = self.velocity.y
#	self.velocity.y = self.velocity.y+owner.gravity*(-1)*get_physics_process_delta_time() 
#	self.applied_velocity.y = min((previous_y+velocity.y)/2,100)
	self.applied_velocity.y -= owner.gravity*get_physics_process_delta_time()
	
func _unhandled_input(event):
	if event.is_action_pressed("jump")&&owner.can_jump:
		emit_signal("finished","jump")
		pass
