extends "res://game/scripts/state_machine/states/on_ground.gd"


func enter():
	#owner.get_node("AnimationPlayer").play("idle")
	play_anim("player_idle")
	self.applied_velocity = Vector2();
	pass


func handle_input(event):
	return .handle_input(event)


func update(_delta):
	
	var input_direction = get_input_direction()
	if input_direction.x:
		emit_signal("finished", "move")


