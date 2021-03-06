extends "res://game/scripts/state_machine/states/on_ground.gd"

func enter():
	.enter()
	speed = 0.0
	#self.velocity = Vector2(0,0)
	play_anim("player_move")
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	owner.get_node("AudioStreamPlayer2D").stream = load("res://game/resources/sounds/step_left.mp3")
	owner.get_node("AudioStreamPlayer2D").play()
	#owner.play("res://game/resources/sounds/running_on_the_gravel.mp3",true)
	#owner.get_node("AnimationPlayer").play("walk")


func handle_input(event):
	return .handle_input(event)


func update(_delta):
	.update(_delta)
	var input_direction = get_input_direction()
	
	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)

#	if Input.is_action_pressed("run"):
#		#speed = max_run_speed
#		pass
#	else:
	speed = owner.get_walk_speed()

	move(speed, input_direction)
#	if not collision_info:
#		return
#	if speed == max_run_speed and collision_info.collider.is_in_group("environment"):
#		return null


func move(speed, direction):
	self.applied_velocity.x = direction.x * speed
#	owner.move_and_slide(self.velocity, Vector2.UP, 5, 2)
#	if owner.get_slide_count() == 0:
#		return
#	return owner.get_slide_collision(0)

func exit():
	owner.get_node("AudioStreamPlayer2D").stop()
	owner.get_node("AudioStreamPlayer2D").stream = null
	
	#owner.stop("res://game/resources/sounds/running_on_the_gravel.mp3")
	

func _on_AudioStreamPlayer2D_finished():
	if owner.get_node("AudioStreamPlayer2D").stream ==load("res://game/resources/sounds/step_left.mp3"):
		owner.get_node("AudioStreamPlayer2D").stream = load("res://game/resources/sounds/step_right.mp3")
		owner.get_node("AudioStreamPlayer2D").play()
	elif owner.get_node("AudioStreamPlayer2D").stream ==load("res://game/resources/sounds/step_right.mp3"):
		owner.get_node("AudioStreamPlayer2D").stream = load("res://game/resources/sounds/step_play.mp3")
		owner.get_node("AudioStreamPlayer2D").play()
	pass # Replace with function body.
