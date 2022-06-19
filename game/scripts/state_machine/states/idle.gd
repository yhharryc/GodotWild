extends "res://game/scripts/state_machine/states/on_ground.gd"


func enter():
	#owner.get_node("AnimationPlayer").play("idle")
	play_anim("player_idle")
	self.applied_velocity = Vector2(0,0);
	pass


func handle_input(event):
	return .handle_input(event)

func handle_gravity():
	self.applied_velocity.y -= player.gravity*get_physics_process_delta_time()


func update(_delta):
	handle_gravity()
	var input_direction = get_input_direction()
	if input_direction.x:
		emit_signal("finished", "move")


