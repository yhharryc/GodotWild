extends "res://game/scripts/state_machine/states/in_air.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hold_jump_momentum
var momentum_left
func enter():
	play_anim("player_jump")
	owner.jump_count+=1
	self.velocity.y = 0
	momentum_left = owner.maxJumpVelocity - owner.initialJumpVelocity
	#self.velocity += Vector2(0,-400)
	handle_jump()
	
	print_debug(owner.maxJumpVelocity)
	pass

func update(_delta):
	var input_direction = get_input_direction()
	speed = owner.get_walk_speed()
	if not self.velocity:
		self.velocity = Vector2()
	
	
	
	self.applied_velocity.x = input_direction.x * speed
	
	handle_gravity()
	if Input.is_action_pressed("jump"):
		hold_jump_momentum = lerp(0,owner.maxJumpVelocity - owner.initialJumpVelocity,0.1)
		momentum_left -= hold_jump_momentum 
		if momentum_left>0:
			self.applied_velocity.y+= hold_jump_momentum*(-1)
		else:
			self.applied_velocity.y+=momentum_left
			emit_signal("finished","in_air")
	update_look_direction(input_direction)
	if self.applied_velocity.y>=0:
		play_anim("player_fall")
	yield(owner,"character_moved")
	if owner.is_grounded():
		emit_signal("finished","idle")
	pass
	
func handle_jump():
	
	self.applied_velocity.y += owner.initialJumpVelocity*(-1)
	
	pass

	
