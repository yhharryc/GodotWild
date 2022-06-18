extends "res://game/scripts/state_machine/states/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func calculate_gravity(y):
#	var previous_y = self.velocity.y
#	self.velocity.y = self.velocity.y 
#	#return min(y + owner.gravity*(-1), 200)
#	return y + player.gravity*(-1)
#	pass


func update(_delta):
	var input_direction = get_input_direction()
	speed = player.get_walk_speed()
	if not self.velocity:
		self.velocity = Vector2()
#	self.velocity = Vector2(input_direction.x*speed,calculate_gravity(self.velocity.y))
	self.applied_velocity.x = input_direction.x * speed 
	handle_gravity()
	
	update_look_direction(input_direction)
	if player.is_grounded():
		owner.play("res://game/resources/sounds/fall.mp3",false)
		emit_signal("finished","idle")
	pass

func handle_gravity():
	self.applied_velocity.y -= player.gravity*get_physics_process_delta_time()


func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		if player.can_in_air_jump():
			emit_signal("finished","jump")
			owner.in_air_jump_timer = null
		else:
			player.on_ground_jump_timer = get_tree().create_timer(player.on_ground_jump_window,false)
		pass
