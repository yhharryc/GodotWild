extends "res://game/scripts/state_machine/states/motion.gd"


func enter():
	self.applied_velocity.y = 0

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
		
	return .handle_input(event)

func update(_delta):
	
	if not owner.is_grounded():
		emit_signal("finished","in_air")
		
	pass
