extends PlayerState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func enter():
	play_anim("player_die")
	owner.applied_velocity = Vector2()
	owner.find_node("Light2D",true,false).enabled = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta):
	
	#handle_gravity()
	pass
#	pass

func handle_gravity():
	owner.applied_velocity.y -= player.gravity*get_physics_process_delta_time()
	
func _on_animation_finished(_anim_name):
	if _anim_name =="player_die":
		get_tree().root.get_node("Game").restart()

