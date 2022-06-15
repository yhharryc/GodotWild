extends "res://game/scripts/state_machine/states/motion.gd"


func enter():
	owner.jump_count = 0
	self.applied_velocity.y = 0
	if owner.can_on_ground_jump():
		emit_signal("finished","jump")

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
		
	return .handle_input(event)

func update(_delta):
	
	if not owner.is_grounded():
		emit_signal("finished","in_air")
		
	pass

func exit():
	if ! Input.is_action_pressed("jump")&& (!owner.is_grounded()):
		print_debug(self.name+"!!!")
		owner.in_air_jump_timer = get_tree().create_timer(owner.in_air_jump_window,false)
	
	pass
